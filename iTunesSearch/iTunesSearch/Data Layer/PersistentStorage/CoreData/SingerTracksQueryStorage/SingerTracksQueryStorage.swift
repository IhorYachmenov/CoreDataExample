//
//  SingerTrackQueryStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

final class SingerTracksQueryStorage {
    
    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension SingerTracksQueryStorage: SingerTracksQueryStorageInterface {
    
    func fetchSingerTracks(fetchLimit: Int, offset: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        completition(.success([]))
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        completition(.success([]))
    }
    
    
}
