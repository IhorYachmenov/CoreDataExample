//
//  Data Layer Entities.swift
//  Data Model Layer
//
//  Created by user on 02.03.2023.
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

public extension DataModel.SingerTrack {
    init(networkModel: NetworkModel.SingerTrack) {
        self.init(
            trackName: networkModel.trackName.isNil(),
            singerName: networkModel.artistName.isNil(),
            trackPrice: networkModel.trackPrice.isNilToString(),
            country: networkModel.country.isNil(),
            collectionName: networkModel.collectionName.isNil(),
            collectionPrice: networkModel.collectionPrice.isNilToString(),
            releaseDate: networkModel.releaseDate.isNil(),
            genre: networkModel.primaryGenreName.isNil(),
            demoURL: networkModel.previewUrl.isNil(),
            trackImgURL: networkModel.artworkUrl100.isNil(),
            trackId: networkModel.trackId.isNilToString()
        )
    }
}
