//
//  SingerTrackDetailsUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

protocol SingerTrackDetailsUseCaseInterface {
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
}
