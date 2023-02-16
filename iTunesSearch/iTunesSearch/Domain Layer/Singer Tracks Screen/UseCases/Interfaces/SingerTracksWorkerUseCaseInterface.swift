//
//  SingerTrackDataProviderInterface.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Foundation

protocol SingerTracksWorkerUseCaseInterface {
    func downloadAndSaveSingerTrack(name: String, completion: @escaping (Error?) -> ())
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ())
}
