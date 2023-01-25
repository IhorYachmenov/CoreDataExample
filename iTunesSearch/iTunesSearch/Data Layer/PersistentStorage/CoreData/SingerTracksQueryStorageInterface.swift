//
//  SingerTrackQueryStorageInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol SingerTracksQueryStorageInterface {
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ())
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ())
}
