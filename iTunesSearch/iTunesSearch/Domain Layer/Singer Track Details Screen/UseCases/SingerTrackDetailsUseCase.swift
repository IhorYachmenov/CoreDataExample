//
//  SingerTrackDetailsUseCase.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsUseCase {
    private var repository: PersistentStorageRepositoryInterface
    private lazy var client = ImageDownloaderClient()
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension SingerTrackDetailsUseCase: SingerTrackDetailsUseCaseInterface {
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        client.downloadImage(url: url, completion: completion)
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        repository.fetchTrackDetails(trackId: trackId, completion: completion)
    }
}
