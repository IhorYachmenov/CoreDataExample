//
//  AudioPlayerUseCase.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import Infrastructure

public final class AudioPlayerUseCase {
    private lazy var trackDownloaderClient: TrackDownloaderClientInterface = TrackDownloaderClient()
    private var audioClient: AudioClientInterface
    
    public init(audioClient: AudioClientInterface) {
        self.audioClient = audioClient
    }
}

extension AudioPlayerUseCase: AudioPlayerUseCaseInterface {
    public func playTrack(url: String?, completion: @escaping (Error?) -> ()) {
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
    
    public func subscribeOnAudioData(completion: @escaping (MediaModel.AudioData) -> ()) {
        audioClient.dataPublisher = completion
    }
}
