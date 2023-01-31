//
//  StorageSingerTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

final class StorageSingerTracksUseCase: StorageSingerTracksUseCaseInterface {
    
    private var repository: PersistentStorageRepositoryInterface
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
    
    func fetchSingerTracks(completion: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        repository.fetchSingerTracks(completion: { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
        
    }
    
    func saveSingerTrack(track: SingerTrackEntity, completion: @escaping (Result<SingerTrackEntity, StorageError>) -> ()) {
        repository.saveSingerTrack(singerTrack: track, completion: { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
    }
    
    
}
