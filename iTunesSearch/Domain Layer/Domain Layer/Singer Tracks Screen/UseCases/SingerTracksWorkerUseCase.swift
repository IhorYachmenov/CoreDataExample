//
//  SingerTrackDataProvider.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Data_Layer
import Infrastructure

#warning("Use case API")
public final class SingerTracksWorkerUseCase {
    private var download: DownloadSingerTrackUseCaseInterface
    private var storage: StorageSingerTracksUseCaseInterface
    
    public init(useCase download: DownloadSingerTrackUseCaseInterface, useCase storage: StorageSingerTracksUseCaseInterface) {
        self.download = download
        self.storage = storage
    }
}

extension SingerTracksWorkerUseCase: SingerTracksWorkerUseCaseInterface {
    public func downloadAndSaveSingerTrack(name: String, completion: @escaping (Error?) -> ()) {
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
    
    public func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        storage.subscribeOnData(completion: completion)
    }
}

