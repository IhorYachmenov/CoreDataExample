//
//  PersistentStorageRepositoryInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import Data_Model_Layer

public protocol PersistentStorageRepositoryInterface {
    func observeData(completion: @escaping ([DTO.SingerTrack]) -> ())
    func saveSingerTrack(singerTrack: DTO.SingerTrack, completion: @escaping (Error?) -> ())
    func fetchTrackDetails(trackId: String, completion: @escaping (Error?) -> ())
}
