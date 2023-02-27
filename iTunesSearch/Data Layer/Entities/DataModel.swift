//
//  SingerTrackEntiry.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

public enum DataModel {
    public struct SingerTrack {
        public let trackName: String
        public let singerName: String
        public let trackPrice: String
        public let country: String
        public let collectionName: String
        public let collectionPrice: String
        public let releaseDate: String
        public let genre: String
        public let demoURL: String
        public let trackImgURL: String
        public let trackId: String
        
        public init(trackName: String,
                    singerName: String,
                    trackPrice: String,
                    country: String,
                    collectionName: String,
                    collectionPrice: String,
                    releaseDate: String,
                    genre: String,
                    demoURL: String,
                    trackImgURL: String,
                    trackId: String
        ) {
            self.trackName = trackName
            self.singerName = singerName
            self.trackPrice = trackPrice
            self.country = country
            self.collectionName = collectionName
            self.collectionPrice = collectionPrice
            self.releaseDate = releaseDate.parceDateFormat
            self.genre = genre
            self.demoURL = demoURL
            self.trackImgURL = trackImgURL
            self.trackId = trackId
        }
    }
}

/// **CoreData Entities**
extension DataModel.SingerTrack {
    init(entity: SingerTrack) {
        trackName = entity.trackName.isNil()
        singerName = entity.singerName.isNil()
        trackPrice = entity.trackPrice.isNil()
        country = entity.country.isNil()
        collectionName = entity.collectionName.isNil()
        collectionPrice = entity.collectionPrice.isNil()
        releaseDate = entity.releaseDate.isNil()
        genre = entity.genre.isNil()
        demoURL = entity.demoURL.isNil()
        trackImgURL = entity.trackImgURL.isNil()
        trackId = entity.trackId.isNil()
    }
}

