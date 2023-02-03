//
//  SingerTrackQueryStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class QueryWorkerStorage: NSObject, QueryWorkerStorageInterface {
    
    var dataPublisher: (([DataModel.SingerTrack]) -> ())?
    
    private var fetchedResultsController: NSFetchedResultsController<SingerTrack>!
    private var coreDataManager: CoreDataStorageManager = CoreDataStorageManager.shared
    
    override init() {
        super.init()
        setupFetchResultsController(persistentStorage: coreDataManager)
    }
    
    private func setupFetchResultsController(persistentStorage: CoreDataStorageManager) {
        let fetchRequest: NSFetchRequest<SingerTrack> = SingerTrack.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(SingerTrack.trackName), ascending: true)
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
    
    private var fetchedObjects: [DataModel.SingerTrack] {
        guard let data = fetchedResultsController.fetchedObjects else {
            return []
        }
        
        let converted = data.map { $0.toDataEntity() }
        return converted
    }
    
    // MARK: - SingerTracksQueryStorageInterface
    
    func fetchSingerTracks(completion: @escaping (Result<[DataModel.SingerTrack], StorageError>) -> ()) {
        coreDataManager.mainQueueManageObjectContext.perform { [unowned self] in
            let request: NSFetchRequest = SingerTrack.fetchRequest()
            
            do {
                let count = try coreDataManager.mainQueueManageObjectContext.count(for: request)
                let data = try coreDataManager.mainQueueManageObjectContext.fetch(request).map { $0.toDataEntity() }
                
                print("DB count", count)
                completion(.success(data))
            } catch {
                completion(.failure(.readError(error)))
            }
        }
    }
    
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        coreDataManager.privateQueueManageObjectContext.perform { [unowned self] in
            let _ = SingerTrack(query: singerTrack, insertInto: coreDataManager.privateQueueManageObjectContext)
            
            do {
                try coreDataManager.privateQueueManageObjectContext.save()
                print("Data saved successfully private Q🥳")
                completion(.success(singerTrack))
            } catch {
                print("Can't save singer tracks privateQ 😶‍🌫️")
                completion(.failure(.saveError(error)))
            }
        }
    }
}


// MARK: - NSFetchedResultsControllerDelegate
extension QueryWorkerStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("NSFRC count -> ", fetchedResultsController.fetchedObjects?.count ?? 0)
        
        dataPublisher?(fetchedObjects)
    }
}
