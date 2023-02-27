//
//  SingerTrackDetailsUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Data_Layer

public protocol SingerTrackDetailsUseCaseInterface {
    func downloadImage(url: String?, completion: @escaping (Result<Data, Error>) -> ())
    func fetchTrackDetails(trackId: String, completion: @escaping (StorageError?) -> ())
    func subscribeOnTrackData(completion: @escaping (DataModel.SingerTrack?) -> ())
}
