//
//  SingerTrackDataProviderInterface.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Foundation

protocol SingerTrackDataProviderInterface {
    func downloadSingerTrack(singerName: String, completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ())
    
    func fetchFromStorage(completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ())
}
