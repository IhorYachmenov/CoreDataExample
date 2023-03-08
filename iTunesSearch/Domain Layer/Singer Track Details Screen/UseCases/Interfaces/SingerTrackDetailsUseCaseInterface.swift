//
//  SingerTrackDetailsUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation
import Data_Model_Layer

public protocol SingerTrackDetailsUseCaseInterface {
    func downloadImage(url: String?, completion: @escaping (Result<Data, Error>) -> ())
    func fetchTrackDetails(trackId: String, completion: @escaping (Error?) -> ())
    func observeData(completion: @escaping (DTO.SingerTrack?) -> ())
}
