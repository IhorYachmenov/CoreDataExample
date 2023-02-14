//
//  SingerTrackDetailsUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

protocol SingerTrackDetailsUseCaseInterface {
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ())
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
}
