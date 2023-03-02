//
//  SingerTrackScreen.swift
//  Data Model Layer
//
//  Created by user on 02.03.2023.
//

import Foundation

public enum PresentationModel {
    public struct SingerTrack {
        public let trackName: String
        public let singerName: String
        public let trackPrice: String
        public let country: String
        public let trackId: String
    }
}

public extension PresentationModel.SingerTrack {
    init(dataModel: DataModel.SingerTrack) {
        trackName = dataModel.trackName
        singerName = dataModel.singerName
        trackPrice = dataModel.trackPrice.toDollars
        country = dataModel.country
        trackId = dataModel.trackId
    }
}
