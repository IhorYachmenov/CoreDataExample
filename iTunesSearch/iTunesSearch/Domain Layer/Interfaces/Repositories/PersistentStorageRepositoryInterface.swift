//
//  PersistentStorageRepositoryInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol PersistentStorageRepositoryInterface {
    func fetchSingerTracks(fetchLimit: Int, offset: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ())
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ())
}
