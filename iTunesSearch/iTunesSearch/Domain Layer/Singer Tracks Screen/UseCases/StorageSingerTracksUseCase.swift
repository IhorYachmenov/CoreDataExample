//
//  StorageSingerTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

final class StorageSingerTracksUseCase {
    private var repository: PersistentStorageRepositoryInterface
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension StorageSingerTracksUseCase: StorageSingerTracksUseCaseInterface {
    func saveSingerTrack(track: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        repository.saveSingerTrack(singerTrack: track, completion: { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        })
    }
    
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        repository.subscribeOfData(completion: completion)
    }
}
