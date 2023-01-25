//
//  SingerTrackViewEntityEntensions.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

extension Array where Element == SingerTrackViewEntity {
    func toData() -> [SingerTrackEntity] {
        self.map({ SingerTrackEntity(trackName: $0.trackName, singerName: $0.singerName, trackPrice: $0.trackPrice, country: $0.country) })
    }
}
