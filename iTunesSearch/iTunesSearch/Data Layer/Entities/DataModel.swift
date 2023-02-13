//
//  SingerTrackEntiry.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

enum DataModel {
    struct SingerTrack {
        let trackName: String
        let singerName: String
        let trackPrice: String
        let country: String
    }
}

extension DataModel.SingerTrack {
    func toViewEntity() -> PresentationModel.SingerTrackDetail {
        return PresentationModel.SingerTrackDetail()
    }
}

extension Array where Element == DataModel.SingerTrack {
    func toViewEntity() -> [PresentationModel.SingerTrack] {
        return self.map({ PresentationModel.SingerTrack(trackName: $0.trackName, singerName: $0.singerName, trackPrice: $0.trackPrice, country: $0.country) })
    }
}

