//
//  InProgress - QueryWorkerStorageGeneric.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation
import CoreData

final class QueryWorkerStorage<DataType, Entity: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate, QueryWorkerStoragable {
    var dataPublisher: (([Entity]) -> ())?
    
    private var fetchedResultsController: NSFetchedResultsController<Entity>!
    private let coreDataManager: CoreDataStorageManager = CoreDataStorageManager.shared
    private let entityName = NSStringFromClass(Entity.self)
    
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
        completion: @escaping (Result<DataType, StorageError>) -> ()
    ) {
        coreDataManager.privateQueueManageObjectContext.perform { [weak self] in
            
            let entityDescription = NSEntityDescription.entity(forEntityName: self!.entityName, in: self!.coreDataManager.privateQueueManageObjectContext)
            
            guard entityDescription != nil else {
                let failure = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Wrong Entity name 😱"])
                completion(.failure(.saveError(failure)))
                return
            }
            
            let manageObject = NSManagedObject(entity: entityDescription!, insertInto: self?.coreDataManager.privateQueueManageObjectContext)
            #warning("Need to examine")
            Mapper().mapToEntity(from: data, target: manageObject, completion: {
                do {
                    try self?.coreDataManager.privateQueueManageObjectContext.save()
                    print("Data saved successfully private Q🥳")
                    self?.coreDataManager.privateQueueManageObjectContext.reset()
                    completion(.success(data))
                } catch {
                    print("Can't save singer track privateQ 😶‍🌫️")
                    completion(.failure(.saveError(error)))
                }
            })
            
            
        }
    }
        
    func fetchEntity<T>(
        matching keyPath: KeyPath<Entity, T>,
        equalTo value: T,
        completion: @escaping (Result<Entity, StorageError>) -> ()
    ) {
        coreDataManager.mainQueueManageObjectContext.perform { [weak self] in
            let predicate = NSPredicate(format: "%K == %@", keyPath._kvcKeyPathString!, value as! CVarArg)
            
            self?.fetchedResultsController.fetchRequest.fetchLimit = 1
            self?.fetchedResultsController.fetchRequest.predicate = predicate
            
            do {
                try self?.fetchedResultsController.performFetch()
            
                if let obj = self?.fetchedResultsController.fetchedObjects?.first {
                    completion(.success(obj))
                } else {
                    completion(.failure(StorageError.notFoundError))
                }
            } catch {
                completion(.failure(.readError(error)))
            }
        }

    }
  
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("NSFRC count -> ", fetchedResultsController.fetchedObjects?.count ?? 0)
        
        dataPublisher?(fetchedResultsController.fetchedObjects ?? [])
    }
}

