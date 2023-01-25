//
//  ArtistTracksDomainEntityExtensions.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

extension SingerTracksDomainEntity {
    func toDomain() -> [SingerTrackViewEntity] {
        return self.results?.map({
            SingerTrackViewEntity(trackName: $0.trackName.isNil(), singerName: $0.artistName.isNil(), trackPrice: $0.trackPrice.isNilToString(), country: $0.country.isNil())
        }) ?? []
    }
    
    func toData() -> [SingerTrackEntity] {
        return self.results?.map({
            SingerTrackEntity(trackName: $0.trackName.isNil(), singerName: $0.artistName.isNil(), trackPrice: $0.trackPrice.isNilToString(), country: $0.country.isNil())
        }) ?? []
    }
}
