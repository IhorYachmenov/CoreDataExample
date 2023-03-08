//
//  PersistentStorageRepository.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData
import Data_Transfer_Objects

public final class PersistentStorageRepository {
    private lazy var singerTracksQueryStorageGeneric = QueryWorkerStorage<DTO.SingerTrack, SingerTrack>(
        sortDescriptor: \.trackName
    )
    
    public init() {}
}

extension PersistentStorageRepository: PersistentStorageRepositoryInterface {
    public func saveSingerTrack(singerTrack: DTO.SingerTrack, completion: @escaping (Error?) -> ()) {
        singerTracksQueryStorageGeneric.saveDataModel(data: singerTrack, completion: completion)
    }
    
    public func observeData(completion: @escaping ([DTO.SingerTrack]) -> ()) {
        singerTracksQueryStorageGeneric.dataPublisher = { data in
            let dataModels = data.map { DTO.SingerTrack(entity: $0) }
            completion(dataModels)
        }
    }
    
    public func fetchTrackDetails(trackId: String, completion: @escaping (Error?) -> ()) {
        singerTracksQueryStorageGeneric.fetchEntity(matching: \.trackId, equalTo: trackId) { result in
            completion(result)
        }
    }
}


