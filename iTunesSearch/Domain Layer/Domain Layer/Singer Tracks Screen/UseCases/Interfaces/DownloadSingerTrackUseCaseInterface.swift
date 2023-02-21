//
//  SearchSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Data_Layer
import Infrastructure

protocol DownloadSingerTrackUseCaseInterface {
    func downloadSingerTrack(name: String, completion: @escaping (Result<DataModel.SingerTrack, ServiceError>) -> ())
}
