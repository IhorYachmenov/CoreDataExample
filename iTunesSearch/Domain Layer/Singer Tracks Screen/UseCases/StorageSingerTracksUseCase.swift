//
//  StorageSingerTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Data_Layer

public final class StorageSingerTracksUseCase {
    private var repository: PersistentStorageRepositoryInterface
    
    public init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension StorageSingerTracksUseCase: StorageSingerTracksUseCaseInterface {
    public func saveSingerTrack(track: DataModel.SingerTrack, completion: @escaping (StorageError?) -> ()) {
        repository.saveSingerTrack(singerTrack: track, completion: { failure in
            if let failure = failure {
                completion(failure)
            }
        })
    }
    
    public func subscribeOnData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        repository.subscribeOnData(completion: completion)
    }
}
