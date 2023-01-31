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
    
    func fetchSingerTracks(completion: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        singerTracksQueryStorage.fetchSingerTracks(completion: completion)
    }
    
    func saveSingerTrack(singerTrack: SingerTrackEntity, completion: @escaping (Result<SingerTrackEntity, StorageError>) -> ()) {
        singerTracksQueryStorage.saveSingerTrack(singerTrack: singerTrack, completion: completion)
    }
    
    
}

