//
//  StorageSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Data_Layer

protocol StorageSingerTracksUseCaseInterface {
    func saveSingerTrack(track: DataModel.SingerTrack, completion: @escaping (StorageError?) -> ())
    func subscribeOnData(completion: @escaping ([DataModel.SingerTrack]) -> ())
}
