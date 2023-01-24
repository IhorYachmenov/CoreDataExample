//
//  ArtistTracksDomainEntityExtensions.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

extension ArtistTracksDomainEntity {
    func toDomain() -> [ArtistsTrackViewEntity] {
        return self.results.map({ ArtistsTrackViewEntity(trackName: $0.trackName, artistName: $0.artistName, trackPrice: String($0.trackPrice), country: $0.country)})
    }
}
