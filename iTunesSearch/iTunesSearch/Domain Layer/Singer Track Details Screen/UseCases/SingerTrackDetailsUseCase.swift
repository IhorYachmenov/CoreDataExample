//
//  SingerTrackDetailsUseCase.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsUseCase {
    private var repository: PersistentStorageRepositoryInterface
    private var imageDownloaderClient: ImageDownloaderClientInterface
    
    init(storageRepository: PersistentStorageRepositoryInterface, imageDownloaderClient: ImageDownloaderClientInterface) {
        repository = storageRepository
        self.imageDownloaderClient = imageDownloaderClient
    }
}

extension SingerTrackDetailsUseCase: SingerTrackDetailsUseCaseInterface {
    func downloadImage(url: String?, completion: @escaping (Result<Data, Error>) -> ()) {
        imageDownloaderClient.downloadImage(url: url, completion: completion)
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (StorageError?) -> ()) {
        repository.fetchTrackDetails(trackId: trackId, completion: completion)
    }
    
    func subscribeOnTrackData(completion: @escaping (DataModel.SingerTrack?) -> ()) {
        repository.subscribeOnData { data in
            completion(data.first)
        }
    }
}
