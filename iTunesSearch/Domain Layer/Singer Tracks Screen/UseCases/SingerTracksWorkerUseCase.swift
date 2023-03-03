//
//  SingerTrackDataProvider.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Foundation
import Infrastructure
import Data_Layer
import Data_Model_Layer

public final class SingerTracksWorkerUseCase {
    private var download: DownloadSingerTrackUseCaseInterface
    private var storage: StorageSingerTracksUseCaseInterface
    
    public init(storageRepository: PersistentStorageRepositoryInterface) {
        self.download = DownloadSingerTrackUseCase()
        self.storage = StorageSingerTracksUseCase(storageRepository: storageRepository)
    }
}

extension SingerTracksWorkerUseCase: SingerTracksWorkerUseCaseInterface {
    public func downloadTrack(name: String, completion: @escaping (Error?) -> ()) {
        download.downloadSingerTrack(name: name) { [weak self] result in
            switch result {
            case .success(let success):
                self?.storage.saveSingerTrack(track: success) { failure in
                    if let failure = failure {
                        completion(failure)
                    }
                }
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    public func observeData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        storage.observeStorageData(completion: completion)
    }
}

