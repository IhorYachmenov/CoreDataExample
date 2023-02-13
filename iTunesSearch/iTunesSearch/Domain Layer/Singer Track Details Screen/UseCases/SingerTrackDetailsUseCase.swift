//
//  SingerTrackDetailsUseCase.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsUseCase {
    private var repository: PersistentStorageRepositoryInterface
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension SingerTrackDetailsUseCase: SingerTrackDetailsUseCaseInterface {
    func fetchTrackDetailsWith(id: Int, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        repository.fetchTrackDetailsWith(id: id, completion: completion)
    }
}
