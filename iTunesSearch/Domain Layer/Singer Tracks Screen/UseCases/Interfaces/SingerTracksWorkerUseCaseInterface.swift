//
//  SingerTrackDataProviderInterface.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Data_Layer

public protocol SingerTracksWorkerUseCaseInterface {
    func downloadTrack(name: String, completion: @escaping (Error?) -> ())
    func observeData(completion: @escaping ([DataModel.SingerTrack]) -> ())
}
