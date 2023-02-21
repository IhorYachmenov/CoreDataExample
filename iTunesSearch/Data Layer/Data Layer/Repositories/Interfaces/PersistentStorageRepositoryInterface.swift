//
//  PersistentStorageRepositoryInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

public protocol PersistentStorageRepositoryInterface {
    func subscribeOnData(completion: @escaping ([DataModel.SingerTrack]) -> ())
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (StorageError?) -> ())
    func fetchTrackDetails(trackId: String, completion: @escaping (StorageError?) -> ())
}
