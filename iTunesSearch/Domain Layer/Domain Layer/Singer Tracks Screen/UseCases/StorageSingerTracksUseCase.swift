//
//  StorageSingerTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Data_Layer

final class StorageSingerTracksUseCase {
    private var repository: PersistentStorageRepositoryInterface
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension StorageSingerTracksUseCase: StorageSingerTracksUseCaseInterface {
    func saveSingerTrack(track: DataModel.SingerTrack, completion: @escaping (StorageError?) -> ()) {
        repository.saveSingerTrack(singerTrack: track, completion: { failure in
            if let failure = failure {
                completion(failure)
            }
        })
    }
    
    func subscribeOnData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        repository.subscribeOnData(completion: completion)
    }
}
