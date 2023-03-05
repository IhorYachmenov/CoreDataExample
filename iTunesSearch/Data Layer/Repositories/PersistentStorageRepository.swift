//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData
import Data_Model_Layer

public final class PersistentStorageRepository {
    private lazy var singerTracksQueryStorageGeneric = QueryWorkerStorage<DataModel.SingerTrack, SingerTrack>(
        sortDescriptor: \.trackName
    )
    
    public init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    public func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Error?) -> ()) {
        singerTracksQueryStorageGeneric.saveDataModel(data: singerTrack, completion: completion)
    }
    
    public func observeData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        singerTracksQueryStorageGeneric.dataPublisher = { data in
            let dataModels = data.map { DataModel.SingerTrack(entity: $0) }
            completion(dataModels)
        }
    }
    
    public func fetchTrackDetails(trackId: String, completion: @escaping (Error?) -> ()) {
        singerTracksQueryStorageGeneric.fetchEntity(matching: \.trackId, equalTo: trackId) { result in
            completion(result)
        }
    }
}


