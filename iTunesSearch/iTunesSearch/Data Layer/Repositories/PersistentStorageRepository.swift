//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

final class PersistentStorageRepository {
    
    private lazy var singerTracksQueryStorage: QueryWorkerStorageInterface = QueryWorkerStorage()
    
    init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        singerTracksQueryStorage.saveSingerTrack(singerTrack: singerTrack, completion: completion)
    }
    
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        singerTracksQueryStorage.dataPublisher = completion
    }
}


