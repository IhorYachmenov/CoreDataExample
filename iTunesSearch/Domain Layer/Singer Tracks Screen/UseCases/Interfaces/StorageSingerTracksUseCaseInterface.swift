//
//  StorageSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import Data_Model_Layer

protocol StorageSingerTracksUseCaseInterface {
    func saveSingerTrack(track: DTO.SingerTrack, completion: @escaping (Error?) -> ())
    func observeStorageData(completion: @escaping ([DTO.SingerTrack]) -> ())
}
