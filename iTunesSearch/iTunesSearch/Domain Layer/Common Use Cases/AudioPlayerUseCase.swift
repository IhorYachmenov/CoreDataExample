//
//  AudioPlayerUseCase.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import Foundation

final class AudioPlayerUseCase {
    private lazy var trackDownloaderClient: TrackDownloaderClientInterface = TrackDownloaderClient()
    private var audioClient: AudioClientInterface
    
    init(audioClient: AudioClientInterface) {
        self.audioClient = audioClient
    }
}

extension AudioPlayerUseCase: AudioPlayerUseCaseInterface {
    func playTrack(url: String?, completion: @escaping (Error?) -> ()) {
        trackDownloaderClient.downloadTrack(url: url) { [weak self] result in
            switch result {
            case .success(let success):
                self?.audioClient.playTrack(url: success, completion: { error in
                    if let error = error {
                        completion(error)
                    }
                })
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    func subscribeOnAudioData(completion: @escaping (MediaModel.AudioData) -> ()) {
        audioClient.dataPublisher = completion
    }
}
