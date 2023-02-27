//
//  AudioPlayerUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import Infrastructure

public protocol AudioPlayerUseCaseInterface {
    func playTrack(url: String?, completion: @escaping (Error?) -> ())
    func observeData(completion: @escaping (MediaModel.AudioData) -> ())
}
