//
//  StorageSingerTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

final class StorageSingerTracksUseCase: StorageSingerTracksUseCaseInterface {
    
    init() {}
    
    private lazy var persistentStorage: PersistentStorageRepositoryInterface = PersistentStorageRepository()
    
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ()) {
        persistentStorage.fetchSingerTracks(fetchLimit: fetchLimit, completition: { result in
            switch result {
            case .success(let success):
                completition(.success(success.toView()))
            case .failure(let failure):
                completition(.failure(failure))
            }
        })
        
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackViewEntity], completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ()) {
        persistentStorage.saveSingerTracks(singerTracks: singerTracks.toData(), completition: { result in
            switch result {
            case .success(let success):
                completition(.success(success.toView()))
            case .failure(let failure):
                completition(.failure(failure))
            }
        })
    }
    
    
}
