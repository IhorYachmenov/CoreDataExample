//
//  CoreDataStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

#warning("Error")
#warning("module name reversing")
public enum StorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
    case notFoundError(Error)
}

final class CoreDataStorageManager {
    static let shared = CoreDataStorageManager()
    
    init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
        let bundle = Bundle(for: CoreDataStorageManager.self)
        guard
            let modelUrl = bundle.url(forResource: "SingerTrackDataModel", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelUrl)
        else {
            fatalError("No model")
        }
        let container = NSPersistentContainer(name: "Container", managedObjectModel: model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreData Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    private(set) lazy var privateQueueManageObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    var mainQueueManageObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

