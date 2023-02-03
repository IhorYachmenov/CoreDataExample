//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class PersistentStorageRepository {
    
    private lazy var singerTracksQueryStorage: QueryWorkerStorageInterface = QueryWorkerStorage()
    private lazy var singerTracksQueryStorageGeneric = QueryWorkerStorageGeneric<DataModel.SingerTrack, SingerTrack>(fetchRequest: SingerTrack.fetchRequest())
    
    init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
//        singerTracksQueryStorage.saveSingerTrack(singerTrack: singerTrack, completion: completion)
        singerTracksQueryStorageGeneric.saveSingerTrack(singerTrack: singerTrack, entityDescription: SingerTrack.entity(), completion: completion)
    }
    
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
//        singerTracksQueryStorage.dataPublisher = completion
        singerTracksQueryStorageGeneric.dataPublisher = { data in
            let dataModels = data.map{ $0.toDataEntity() }
            completion(dataModels)
        }
        
    }
}


