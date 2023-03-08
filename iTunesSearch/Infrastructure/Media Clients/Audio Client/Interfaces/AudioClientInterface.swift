//
//  AudioClientInterface.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
import Data_Transfer_Objects

public protocol AudioClientInterface {
    var dataPublisher: ((DTO.AudioData) -> ())? { get set }
    func playTrack(url: URL, completion: @escaping (Error?) -> ())
}
