//
//  AudioClientInterface.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation

public enum MediaModel {
    public struct AudioData {
        public let currentTime: String
        public let duration: String
        public var isPlaying: Bool
        public var progress: Float
    }
}

public protocol AudioClientInterface {
    var dataPublisher: ((MediaModel.AudioData) -> ())? { get set }
    func playTrack(url: URL, completion: @escaping (Error?) -> ())
}
