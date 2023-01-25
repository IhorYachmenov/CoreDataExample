//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

final class PersistentStorageRepository {
    
    private lazy var singerTracksQueryStorage: SingerTracksQueryStorageInterface = SingerTracksQueryStorage()
    
    init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    
    func fetchSingerTracks(fetchLimit: Int, offset: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        singerTracksQueryStorage.fetchSingerTracks(fetchLimit: fetchLimit, offset: offset, completition: completition)
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        singerTracksQueryStorage.saveSingerTracks(singerTracks: singerTracks, completition: completition)
    }
    
    
}
