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
    private var offsetNumber: Int = 0
    
    init(persistentStorage: SingerTrackStorage = SingerTrackStorage.shared) {
        storage = persistentStorage
    }
    
}

extension SingerTracksQueryStorage: SingerTracksQueryStorageInterface {
    
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {

        do {

            let request: NSFetchRequest = SingerTrack.fetchRequest()

            let count = try storage.fetchManageObjectContext.count(for: request)
            let data = try storage.fetchManageObjectContext.fetch(request)
            
            print( "DB count", count)
            completition(.success(data.toData()))
        } catch {

            completition(.failure(.readError(error)))
        }
        
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        
        guard !singerTracks.isEmpty else { return }
 
        singerTracks.forEach { let _ = SingerTrack(query: $0, insertInto: storage.saveManageObjectContext) }
        
        storage.saveContext { error in
            guard error != nil else {
                completition(.success(singerTracks))
                return
            }
            completition(.failure(error!))
        }
    }
    
    
}
