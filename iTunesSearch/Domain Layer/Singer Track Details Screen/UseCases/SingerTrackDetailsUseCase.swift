//
//  SingerTrackDetailsUseCase.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation
import Data_Layer
import Infrastructure
import Data_Transfer_Objects

public final class SingerTrackDetailsUseCase {
    private var repository: PersistentStorageRepositoryInterface
    private var imageDownloaderClient: ImageDownloaderClientInterface
    
    public init(storageRepository: PersistentStorageRepositoryInterface, imageDownloaderClient: ImageDownloaderClientInterface) {
        repository = storageRepository
        self.imageDownloaderClient = imageDownloaderClient
    }
}

extension SingerTrackDetailsUseCase: SingerTrackDetailsUseCaseInterface {
    public func downloadImage(url: String?, completion: @escaping (Result<Data, Error>) -> ()) {
        imageDownloaderClient.downloadImage(url: url, completion: completion)
    }
    
    public func fetchTrackDetails(trackId: String, completion: @escaping (Error?) -> ()) {
        repository.fetchTrackDetails(trackId: trackId, completion: completion)
    }
    
    public func observeData(completion: @escaping (DTO.SingerTrack?) -> ()) {
        repository.observeData { data in
            completion(data.first)
        }
    }
}
