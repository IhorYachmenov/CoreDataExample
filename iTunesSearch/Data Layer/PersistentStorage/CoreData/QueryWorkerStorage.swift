//
//  InProgress - QueryWorkerStorageGeneric.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation
import CoreData

final class QueryWorkerStorage<DataType, Entity: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate, QueryWorkerStoragable {
    private var fetchedResultsController: NSFetchedResultsController<Entity>!
    private let coreDataManager: CoreDataStorageManager = CoreDataStorageManager.shared
    private let entityName = NSStringFromClass(Entity.self)
    
    var dataPublisher: (([Entity]) -> ())?
    
    init<T>(sortDescriptor: KeyPath<Entity, T>) {
        super.init()
        setupFetchResultsController(persistentStorage: coreDataManager, entityName: entityName, sortDescriptor: sortDescriptor)
    }
    
    private func setupFetchResultsController<T>(
        persistentStorage: CoreDataStorageManager,
        entityName: String,
        sortDescriptor: KeyPath<Entity, T>
    ) {
        let fetchRequest = NSFetchRequest<Entity>.init(entityName: entityName)
        let sort = NSSortDescriptor(keyPath: sortDescriptor, ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: persistentStorage.mainQueueManageObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
        
        DispatchQueue.main.async { [weak self] in
            self?.dataPublisher?(self?.fetchedResultsController.fetchedObjects ?? [])
        }
    }
    
    // MARK: - QueryWorkerStoragable
    func saveDataModel(
        data: DataType,
        completion: @escaping (Error?) -> ()
    ) {
        coreDataManager.privateQueueManageObjectContext.perform { [weak self] in
            
            let entityDescription = NSEntityDescription.entity(forEntityName: self!.entityName, in: self!.coreDataManager.privateQueueManageObjectContext)
            
            guard entityDescription != nil else {
                completion(NSError.error(msg: Constants.Error.CoreData.dataNotSaved))
                return
            }
            
            let manageObject = NSManagedObject(entity: entityDescription!, insertInto: self?.coreDataManager.privateQueueManageObjectContext)
            
            Mapper().mapToEntity(from: data, target: manageObject, completion: {
                do {
                    try self?.coreDataManager.privateQueueManageObjectContext.save()
                    self?.coreDataManager.privateQueueManageObjectContext.reset()
                    
                    completion(nil)
                } catch {
                    completion(error)
                }
            })
        }
    }
        
    func fetchEntity<T>(
        matching keyPath: KeyPath<Entity, T>,
        equalTo value: T,
        completion: @escaping (Error?) -> ()
    ) {
        coreDataManager.mainQueueManageObjectContext.perform { [weak self] in
            let predicate = NSPredicate(format: "%K == %@", keyPath._kvcKeyPathString!, value as! CVarArg)
            
            self?.fetchedResultsController.fetchRequest.fetchLimit = 1
            self?.fetchedResultsController.fetchRequest.predicate = predicate
            
            do {
                try self?.fetchedResultsController.performFetch()
            
                if let obj = self?.fetchedResultsController.fetchedObjects?.first {
                    self?.dataPublisher?([obj])
                    completion(nil)
                } else {
                    completion(NSError.error(msg: Constants.Error.CoreData.dataNotFound))
                }
            } catch {
                completion(error)
            }
        }

    }
  
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        dataPublisher?(fetchedResultsController.fetchedObjects ?? [])
    }
}

