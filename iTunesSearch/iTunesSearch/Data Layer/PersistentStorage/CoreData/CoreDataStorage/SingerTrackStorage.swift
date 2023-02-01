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
    
    private(set) lazy var saveManageObjectContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    private(set) lazy var fetchManageObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func saveContext(completition: @escaping ((StorageError?) -> ())) {
        
        guard saveManageObjectContext.hasChanges else { return }
  
        saveManageObjectContext.perform {
            do {
                try self.saveManageObjectContext.save()
                print("Data saved successfully 🥳")
                completition(nil)

            } catch {
                print("Can't save singer tracks 😶‍🌫️")
                completition(.saveError(error))
            }
        }
    }
    
    func saveMainContext(completition: @escaping ((StorageError?) -> ())) {
        
        guard fetchManageObjectContext.hasChanges else { return }
  
        fetchManageObjectContext.perform {
            do {
                try self.fetchManageObjectContext.save()
                print("Data saved successfully main 🥳")
                completition(nil)
                

            } catch {
                print("Can't save singer tracks main 😶‍🌫️")
                completition(.saveError(error))
            }
        }
    }
}

