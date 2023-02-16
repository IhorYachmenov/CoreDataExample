//
//  AudioClientInterface.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation

enum MediaModel {
    struct AudioDetail {
        let currentTime: String
        let duration: String
        var isPlaying: Bool
        var progress: Float
    }
}

protocol AudioClientInterface {
    var dataPublisher: ((Result<MediaModel.AudioDetail, Error>) -> ())? { get set }
    func playTrack(url: URL, completion: @escaping (Error?) -> ())
}
