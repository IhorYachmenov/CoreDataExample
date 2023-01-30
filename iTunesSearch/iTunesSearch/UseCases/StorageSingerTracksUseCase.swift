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
    
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ()) {
        repository.fetchSingerTracks(fetchLimit: fetchLimit, completition: { result in
            switch result {
            case .success(let success):
                completition(.success(success.toView()))
            case .failure(let failure):
                completition(.failure(failure))
            }
        })
        
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackViewEntity], completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ()) {
        repository.saveSingerTracks(singerTracks: singerTracks.toData(), completition: { result in
            switch result {
            case .success(let success):
                completition(.success(success.toView()))
            case .failure(let failure):
                completition(.failure(failure))
            }
        })
    }
    
    
}
