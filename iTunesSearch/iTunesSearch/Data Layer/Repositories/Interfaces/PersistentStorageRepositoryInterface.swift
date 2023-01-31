//
//  PersistentStorageRepositoryInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol PersistentStorageRepositoryInterface {
    func fetchSingerTracks(completion: @escaping (Result<[SingerTrackEntity], StorageError>) -> ())
    func saveSingerTrack(singerTrack: SingerTrackEntity, completion: @escaping (Result<SingerTrackEntity, StorageError>) -> ())
}
