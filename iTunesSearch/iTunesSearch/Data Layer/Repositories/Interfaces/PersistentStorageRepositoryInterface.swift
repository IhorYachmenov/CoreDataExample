//
//  PersistentStorageRepositoryInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol PersistentStorageRepositoryInterface {
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ())
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
    func fetchTrackDetailsWith(id: Int, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
}
