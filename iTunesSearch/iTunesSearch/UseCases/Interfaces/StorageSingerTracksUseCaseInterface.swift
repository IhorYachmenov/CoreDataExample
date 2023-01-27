//
//  StorageSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol StorageSingerTracksUseCaseInterface {
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ())
    func saveSingerTracks(singerTracks: [SingerTrackViewEntity], completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ())
}
