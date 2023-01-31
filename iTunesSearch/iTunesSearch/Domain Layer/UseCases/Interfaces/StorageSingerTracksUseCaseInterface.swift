//
//  StorageSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol StorageSingerTracksUseCaseInterface {
    func fetchSingerTracks(completion: @escaping (Result<[SingerTrackEntity], StorageError>) -> ())
    func saveSingerTrack(track: SingerTrackEntity, completion: @escaping (Result<SingerTrackEntity, StorageError>) -> ())
}
