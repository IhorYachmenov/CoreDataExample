//
//  SingerTrackQueryStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class SingerTracksQueryStorage: NSObject, SingerTracksQueryStorageInterface {
    
    var subscribeOfData: (([DataModel.SingerTrack]) -> ())?
    
    private var fetchedResultsController: NSFetchedResultsController<SingerTrack>!
    private var storage: SingerTrackStorage!
    
    init(persistentStorage: SingerTrackStorage = SingerTrackStorage.shared) {
        
        storage = persistentStorage
        
        let fetchRequest: NSFetchRequest<SingerTrack> = SingerTrack.fetchRequest()
        let sort = NSSortDescriptor(key: #keyPath(SingerTrack.trackName), ascending: true)
        fetchRequest.sortDescriptors = [sort]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: persistentStorage.fetchManageObjectContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        
        super.init()
        
        setupFetchResultsController()
    }
    
    private func setupFetchResultsController() {
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
    }
    
    
    
 
    // MARK: - SingerTracksQueryStorageInterface
    func fetchSingerTracks(completion: @escaping (Result<[DataModel.SingerTrack], StorageError>) -> ()) {
        
        do {
            let request: NSFetchRequest = SingerTrack.fetchRequest()
            
            let count = try storage.fetchManageObjectContext.count(for: request)
            let data = try storage.fetchManageObjectContext.fetch(request).map{ $0.toDataEntity() }
            
            print( "DB count", count)
            completion(.success(data))
        } catch {
            completion(.failure(.readError(error)))
        }
        
    }
    
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        print("Try to save song wiht name ", singerTrack.trackName)
        let _ = SingerTrack(query: singerTrack, insertInto: storage.fetchManageObjectContext)
        //        storage.saveContext { error in
        //            guard error != nil else {
        //                completion(.success(singerTrack))
        //                return
        //            }
        //            completion(.failure(error!))
        //        }
        storage.saveMainContext { error in
            guard error != nil else {
                completion(.success(singerTrack))
                return
            }
            completion(.failure(error!))
        }
        
    }
}


// MARK: - NSFetchedResultsControllerDelegate
extension SingerTracksQueryStorage: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("NSFRC count -> ", fetchedResultsController.fetchedObjects?.count ?? 0)
        guard let data = fetchedResultsController.fetchedObjects else {
            return
        }
        
        let converted = data.map { $0.toDataEntity() }
        subscribeOfData?(converted)
    }
}
