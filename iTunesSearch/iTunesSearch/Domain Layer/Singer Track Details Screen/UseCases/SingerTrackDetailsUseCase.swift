//
//  SingerTrackDetailsUseCase.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

final class SingerTrackDetailsUseCase {
    private var repository: PersistentStorageRepositoryInterface
    private lazy var imageDownloaderClient = ImageDownloaderClient()
    private lazy var trackDonwloaderClient = TrackDownloaderClient()
    private lazy var audioClient = AudioClient()
    
    init(storageRepository: PersistentStorageRepositoryInterface) {
        repository = storageRepository
    }
}

extension SingerTrackDetailsUseCase: SingerTrackDetailsUseCaseInterface {
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        imageDownloaderClient.downloadImage(url: url, completion: completion)
    }
    
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ()) {
        repository.fetchTrackDetails(trackId: trackId, completion: completion)
    }
    
    func playDemo(url: String?) {
        trackDonwloaderClient.downloadTrack(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                print(success)
                self?.audioClient.playTrack(url: success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
