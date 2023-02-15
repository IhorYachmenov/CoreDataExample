//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class PersistentStorageRepository {
    private lazy var singerTracksQueryStorageGeneric = QueryWorkerStorage<DataModel.SingerTrack, SingerTrack>(
        sortDescriptor: \.trackName
    )
    
    init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        singerTracksQueryStorageGeneric.saveDataModel(data: singerTrack, completion: completion)
    }
    
    func subscribeOnData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {    
        singerTracksQueryStorageGeneric.dataPublisher = { data in
            let dataModels = data.map { DataModel.SingerTrack(entity: $0) }
            completion(dataModels)
        }
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        singerTracksQueryStorageGeneric.fetchEntity(matching: \.trackId, equalTo: trackId) { result in
            switch result {
            case .success(let success):
                completion(.success(DataModel.SingerTrack(entity: success)))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}


