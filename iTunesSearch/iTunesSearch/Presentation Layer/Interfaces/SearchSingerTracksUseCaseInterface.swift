//
//  SearchSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol SearchSingerTracksUseCaseInterface {
    func searchSingerTracks(singerName: String, completion: @escaping (Result<[SingerTrackViewEntity], ServiceError>) -> ())
}
