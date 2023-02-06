//
//  InProgress - QueryWorkerStorageGeneric.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation
import CoreData

final class QueryWorkerStorageGeneric<DataType, Entity: NSFetchRequestResult>: NSObject, NSFetchedResultsControllerDelegate, QueryWorkerStorageInterfaceGeneric {
    
    var dataPublisher: (([Entity]) -> ())?
    
    private var fetchedResultsController: NSFetchedResultsController<Entity>!
    private var coreDataManager: CoreDataStorageManager = CoreDataStorageManager.shared
    private var entityName: String!
    
    init(entityName: String, sortDescription: String) {
        super.init()
        self.entityName = entityName
        setupFetchResultsController(persistentStorage: coreDataManager, entityName: entityName, sortDescription: sortDescription)
    }
    
    private func setupFetchResultsController(persistentStorage: CoreDataStorageManager, entityName: String, sortDescription: String) {
        let fetchRequest = NSFetchRequest<Entity>.init(entityName: entityName)
        let sort = NSSortDescriptor(key: sortDescription, ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: persistentStorage.mainQueueManageObjectContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        fetchedResultsController.delegate = self
        
        try? fetchedResultsController.performFetch()
        do {
            try fetchedResultsController.performFetch()
            
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [unowned self] in
                self.dataPublisher?(self.fetchedObjects)
            })
            
        } catch {
            
        }
    }
        
    private var fetchedObjects: [Entity] {
        guard let data = fetchedResultsController.fetchedObjects else {
            return []
        }
        
        return data
    }
    
    // MARK: - QueryWorkerStorageInterfaceGeneric
    
    func saveSingerTrack(singerTrack: DataType, completion: @escaping (Result<DataType, StorageError>) -> ()) {
        coreDataManager.privateQueueManageObjectContext.perform { [unowned self] in
            
            let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: coreDataManager.privateQueueManageObjectContext)
            
            guard entityDescription != nil else {
                let failure = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Wrong Entity name 😱"])
                completion(.failure(.saveError(failure)))
                return
            }
            
            let manageObject = NSManagedObject(entity: entityDescription!, insertInto: coreDataManager.privateQueueManageObjectContext)
            
            Mapper().mapToEntity(from: singerTrack, target: manageObject) { [unowned self] result in
                switch result {
                case .success(_):
                    do {
                        try self.coreDataManager.privateQueueManageObjectContext.save()
                        print("Data saved successfully private Q🥳")
                        self.coreDataManager.privateQueueManageObjectContext.reset()
                        completion(.success(singerTrack))
                    } catch {
                        print("Can't save singer track privateQ 😶‍🌫️")
                        completion(.failure(.saveError(error)))
                    }
                case .failure(let failure):
                    print("Can't map singer track to Entity 😶‍🌫️")
                    completion(.failure(failure))
                }
            }
            
            
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("NSFRC count -> ", fetchedResultsController.fetchedObjects?.count ?? 0)

        dataPublisher?(fetchedObjects)
    }
}

