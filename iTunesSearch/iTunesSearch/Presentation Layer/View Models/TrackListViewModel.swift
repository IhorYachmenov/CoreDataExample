//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

class TrackListViewModel {
    
    init() {}
    
    private lazy var searchArtistTracksUseCase = SearchArtistTracksUseCase()
    
    func findArtistTracks(Artist name: String, completion: @escaping (Result<[ArtistsTrackViewEntity], ServiceError>) -> ()) {
        searchArtistTracksUseCase.searchArtistTracks(artistName: name) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
