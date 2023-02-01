//
//  CoreDataStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

enum StorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

final class SingerTrackStorage {

    static let shared = SingerTrackStorage()
    
    private init() {}

    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SingerTrackDataModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                // TODO: - Log to Crashlytics
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
    
    private(set) lazy var mainQueueManageObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext(completition: @escaping ((StorageError?) -> ())) {
        
        guard privateQueueManageObjectContext.hasChanges else { return }
  
        privateQueueManageObjectContext.perform {
            do {
                try self.privateQueueManageObjectContext.save()
                print("Data saved successfully private Q🥳")
                completition(nil)

            } catch {
                print("Can't save singer tracks privateQ 😶‍🌫️")
                completition(.saveError(error))
            }
        }
    }
    
    
}

