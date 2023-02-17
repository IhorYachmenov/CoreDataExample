//
//  AudioPlayerUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import Foundation

protocol AudioPlayerUseCaseInterface {
    func playTrack(url: String?, completion: @escaping (Error?) -> ())
    func subscribeOnAudioData(completion: @escaping (MediaModel.AudioData) -> ())
}
