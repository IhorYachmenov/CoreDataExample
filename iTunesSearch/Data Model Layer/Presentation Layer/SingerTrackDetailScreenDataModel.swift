//
//  SingerTrackDetailScreen.swift
//  Data Model Layer
//
//  Created by user on 02.03.2023.
//

import Foundation

public extension PresentationModel {
    struct SingerTrackDetails {
        public var details: Details?
        public var track: Track?
        
        public struct Details {
            public let trackName: String
            public let singerName: String
            public let collectionName: String
            public let collectionPrice: String
            public let trackPrice: String
            public let releaseDate: String
            public let genre: String
            public let country: String
            public var image: Data?
        }
        
        public struct Track {
            public let currentTime: String
            public let duration: String
            public let isPlaying: Bool
            public let progress: Float
        }
    }
}

public extension PresentationModel.SingerTrackDetails.Details {
    init(dataModel: DataModel.SingerTrack) {
        trackName = dataModel.trackName
        singerName = dataModel.singerName
        collectionName = dataModel.collectionName
        collectionPrice = dataModel.collectionPrice.toDollars
        trackPrice = dataModel.trackPrice.toDollars
        releaseDate = dataModel.releaseDate
        genre = dataModel.genre
        country = dataModel.country
    }
}

public extension PresentationModel.SingerTrackDetails.Track {
    init(mediaModel: MediaModel.AudioData) {
        currentTime = mediaModel.currentTime
        duration = mediaModel.duration
        isPlaying = mediaModel.isPlaying
        progress = mediaModel.progress
    }
}
