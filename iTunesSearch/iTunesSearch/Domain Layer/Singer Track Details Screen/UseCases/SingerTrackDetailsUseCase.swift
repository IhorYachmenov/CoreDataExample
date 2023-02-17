//
//  SingerTrackDetailsUseCase.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsUseCase {
    private var repository: PersistentStorageRepositoryInterface
    private lazy var imageDownloaderClient: ImageDownloaderClientInterface = ImageDownloaderClient()
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
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
