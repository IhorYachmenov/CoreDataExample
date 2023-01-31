//
//  SingerTrackQueryStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class SingerTracksQueryStorage: NSObject {
    
    private let storage: SingerTrackStorage
    
    init(persistentStorage: SingerTrackStorage = SingerTrackStorage.shared) {
        storage = persistentStorage
    }
}

extension SingerTracksQueryStorage: SingerTracksQueryStorageInterface {
    
    func fetchSingerTracks(completion: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {

        do {
            let request: NSFetchRequest = SingerTrack.fetchRequest()

            let count = try storage.fetchManageObjectContext.count(for: request)
            let data = try storage.fetchManageObjectContext.fetch(request)
            
            print( "DB count", count)
            completion(.success(data.toDataEntity()))
        } catch {
            completion(.failure(.readError(error)))
        }
        
    }
    
    func saveSingerTrack(singerTrack: SingerTrackEntity, completion: @escaping (Result<SingerTrackEntity, StorageError>) -> ()) {
        
        let _ = SingerTrack(query: singerTrack, insertInto: storage.saveManageObjectContext)
        
        storage.saveContext { error in
            guard error != nil else {
                completion(.success(singerTrack))
                return
            }
            completion(.failure(error!))
        }
    }
}
