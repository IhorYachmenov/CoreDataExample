//
//  StorageSingerTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import Data_Layer
import Data_Transfer_Objects

final class StorageSingerTracksUseCase {
    private var repository: PersistentStorageRepositoryInterface
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension StorageSingerTracksUseCase: StorageSingerTracksUseCaseInterface {
    func saveSingerTrack(track: DTO.SingerTrack, completion: @escaping (Error?) -> ()) {
        repository.saveSingerTrack(singerTrack: track, completion: { failure in
            if let failure = failure {
                completion(failure)
            }
        })
    }
    
    func observeStorageData(completion: @escaping ([DTO.SingerTrack]) -> ()) {
        repository.observeData(completion: completion)
    }
}
