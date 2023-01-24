//
//  ArtistTracksDomainEntityExtensions.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

extension SingerTracksDomainEntity {
    func toDomain() -> [SingerTrackViewEntity] {
        return self.results?.map({ SingerTrackViewEntity(trackName: $0.trackName ?? "", singerName: $0.artistName ?? "", trackPrice: String($0.trackPrice ?? 0), country: $0.country ?? "")}) ?? []
    }
}
