//
//  SingerTrackDataProvider.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Foundation

class SingerTracksWorkerUseCase {
    private var download: DownloadSingerTrackUseCaseInterface
    private var storage: StorageSingerTracksUseCaseInterface
    
    init(useCase download: DownloadSingerTrackUseCaseInterface, useCase storage: StorageSingerTracksUseCaseInterface) {
        self.download = download
        self.storage = storage
    }
}

extension SingerTracksWorkerUseCase: SingerTracksWorkerUseCaseInterface {
    func downloadAndSaveSingerTrack(name: String, completion: @escaping (Result<DataModel.SingerTrack, Error>) -> ()) {
        download.downloadSingerTrack(name: name) { [weak self] result in
            switch result {
            case .success(let success):
                
                self?.storage.saveSingerTrack(track: success) { result in
                    switch result {
                    case .success(let success):
                        completion(.success(success))
                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            case .failure(let failure):
                print(failure)
                completion(.failure(failure))
            }
        }
    }
    
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        storage.subscribeOfData(completion: completion)
    }
}

