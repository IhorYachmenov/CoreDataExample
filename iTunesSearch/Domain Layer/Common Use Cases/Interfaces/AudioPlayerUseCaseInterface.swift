//
//  AudioPlayerUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import Foundation
import Data_Transfer_Objects

public protocol AudioPlayerUseCaseInterface {
    func playTrack(url: String?, completion: @escaping (Error?) -> ())
    func observeData(completion: @escaping (DTO.AudioData) -> ())
}
