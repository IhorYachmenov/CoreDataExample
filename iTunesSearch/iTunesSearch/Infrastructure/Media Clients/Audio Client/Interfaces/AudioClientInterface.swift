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
        let isPaused: Bool
        let progress: Progress
    }
}

protocol AudioClientInterface {
    associatedtype AudioObject
    var audioDataPublisher: ((Result<AudioObject, Error>) -> ())? { get set }
}
