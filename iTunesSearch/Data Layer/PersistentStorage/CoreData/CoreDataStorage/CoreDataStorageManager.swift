//
//  CoreDataStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

//image list -f --section=__TEXT image list -b -o  otool -L Data_Layer.framework/Data_Layer


final class CoreDataStorageManager {
    static let shared = CoreDataStorageManager()
//    com.example-itunes.presentation.domain.data.data-bundle
    init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
//        let bundle = Bundle.main//(identifier: "com.example-itunes.presentation.domain.data")!
//        let bundle = Bundle(for: CoreDataStorageManager.self)

//        let bundlePath = Bundle.main.path(forResource: "DataLayerResourcesBundle", ofType: "bundle")!
        let bundle = Bundle.main
        
        guard
//            let modelUrl = bundle.url(forResource: "SingerTrackDataModel", withExtension: "momd"),
            let modelUrl = bundle.url(forResource: "SingerTrackDataModelN", withExtension: "momd"),
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

