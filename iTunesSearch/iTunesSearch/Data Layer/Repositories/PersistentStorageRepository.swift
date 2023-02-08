//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class PersistentStorageRepository {
//    private lazy var singerTracksQueryStorage: QueryWorkerStorageInterface = QueryWorkerStorage()
    
    private lazy var singerTracksQueryStorageGeneric = QueryWorkerStorage<DataModel.SingerTrack, SingerTrack>(
        sortDescriptor: \.trackName
    )
    
    init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
//        singerTracksQueryStorage.saveSingerTrack(singerTrack: singerTrack, completion: completion)
        
        singerTracksQueryStorageGeneric.saveDataModel(data: singerTrack, completion: completion)
    }
    
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
//        singerTracksQueryStorage.dataPublisher = completion
        
        singerTracksQueryStorageGeneric.dataPublisher = { data in
            let dataModels = data.map { $0.toDataEntity() }
            completion(dataModels)
        }
    }
}


