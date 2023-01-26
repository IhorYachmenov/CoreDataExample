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
        return container
    }()
    
    lazy var saveManageObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = fetchManageObjectContext
        return context
    }()
    
    lazy var fetchManageObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    func saveContext(completition: @escaping ((StorageError?) -> ())) {
        guard saveManageObjectContext.hasChanges else { return }
        
        do {
            try self.saveManageObjectContext.save()
            
            self.fetchManageObjectContext.performAndWait {
                do {
                    try self.fetchManageObjectContext.save()
                    print("Data saved successfully 🥳")
                    completition(nil)
                } catch {
                    print("Can't save singer tracks 😶‍🌫️")
                    completition(.saveError(error))
                }
            }

        } catch {
            print("Can't save singer tracks 😶‍🌫️")
            completition(.saveError(error))
        }
        
        
    }
    
}

