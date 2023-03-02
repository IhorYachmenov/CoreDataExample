//
//  CoreDataStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class CoreDataStorageManager {
    static let shared = CoreDataStorageManager()

    init() {}
    
    private func createEntity() -> NSManagedObjectModel {
        let singerTrackEntity = NSEntityDescription()
        singerTrackEntity.name = "SingerTrack"
        singerTrackEntity.managedObjectClassName = NSStringFromClass(SingerTrack.self)
        
        let trackPriceAttribute = NSAttributeDescription()
        trackPriceAttribute.name = "trackPrice"
        trackPriceAttribute.attributeType = .stringAttributeType
        trackPriceAttribute.isOptional = false
        
        let trackNameAttribute = NSAttributeDescription()
        trackNameAttribute.name = "trackName"
        trackNameAttribute.attributeType = .stringAttributeType
        trackNameAttribute.isOptional = false
        
        let trackImgURLAttribute = NSAttributeDescription()
        trackImgURLAttribute.name = "trackImgURL"
        trackImgURLAttribute.attributeType = .stringAttributeType
        trackImgURLAttribute.isOptional = false
        
        let trackIdAttribute = NSAttributeDescription()
        trackIdAttribute.name = "trackId"
        trackIdAttribute.attributeType = .stringAttributeType
        trackIdAttribute.isOptional = false
        
        let singerNameAttribute = NSAttributeDescription()
        singerNameAttribute.name = "singerName"
        singerNameAttribute.attributeType = .stringAttributeType
        singerNameAttribute.isOptional = false
        
        let releaseDateAttribute = NSAttributeDescription()
        releaseDateAttribute.name = "releaseDate"
        releaseDateAttribute.attributeType = .stringAttributeType
        releaseDateAttribute.isOptional = false
        
        let genreAttribute = NSAttributeDescription()
        genreAttribute.name = "genre"
        genreAttribute.attributeType = .stringAttributeType
        genreAttribute.isOptional = false
        
        let demoURLAttribute = NSAttributeDescription()
        demoURLAttribute.name = "demoURL"
        demoURLAttribute.attributeType = .stringAttributeType
        demoURLAttribute.isOptional = false
        
        let countryAttribute = NSAttributeDescription()
        countryAttribute.name = "country"
        countryAttribute.attributeType = .stringAttributeType
        countryAttribute.isOptional = false
        
        let collectionPriceAttribute = NSAttributeDescription()
        collectionPriceAttribute.name = "collectionPrice"
        collectionPriceAttribute.attributeType = .stringAttributeType
        collectionPriceAttribute.isOptional = false
        
        let collectionNameAttribute = NSAttributeDescription()
        collectionNameAttribute.name = "collectionName"
        collectionNameAttribute.attributeType = .stringAttributeType
        collectionNameAttribute.isOptional = false
        
        singerTrackEntity.properties = [
            trackPriceAttribute,
            trackNameAttribute,
            trackImgURLAttribute,
            trackIdAttribute,
            singerNameAttribute,
            releaseDateAttribute,
            genreAttribute,
            demoURLAttribute,
            countryAttribute,
            collectionPriceAttribute,
            collectionNameAttribute]

        let model = NSManagedObjectModel()
        model.entities = [singerTrackEntity]
        
        return model
    }

    private lazy var persistentContainer: NSPersistentContainer = {
//        let bundle = Bundle(for: CoreDataStorageManager.self)

//        let bundle = Bundle.main
//
//        guard
//            let modelUrl = bundle.url(forResource: "SingerTrackDataModel", withExtension: "momd"),
//            let modelUrl = bundle.url(forResource: "SingerTrackDataModelB", withExtension: "momd"),
//            let model = NSManagedObjectModel(contentsOf: modelUrl)
//        else {
//            fatalError("No model")
//        }
        
        let model = createEntity()
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

