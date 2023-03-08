//
//  SingerTrackDataProviderInterface.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Foundation
import Data_Transfer_Objects

public protocol SingerTracksWorkerUseCaseInterface {
    func downloadTrack(name: String, completion: @escaping (Error?) -> ())
    func observeData(completion: @escaping ([DTO.SingerTrack]) -> ())
}
