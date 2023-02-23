//
//  SingerTrackEntiry.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

#warning("swift only frameworks, objc+swift, umbrella..., module.modulemap, cocoapods")
import Infrastructure

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

public extension DataModel.SingerTrack {
    init(networkModel: NetworkModel.SingerTrack) {
        trackName = networkModel.trackName.isNil()
        singerName = networkModel.artistName.isNil()
        trackPrice = networkModel.trackPrice.isNilToString()
        country = networkModel.country.isNil()
        collectionName = networkModel.collectionName.isNil()
        collectionPrice = networkModel.collectionPrice.isNilToString()
        releaseDate = networkModel.releaseDate.isNil().parceDateFormat
        genre = networkModel.primaryGenreName.isNil()
        demoURL = networkModel.previewUrl.isNil()
        trackImgURL = networkModel.artworkUrl100.isNil()
        trackId = networkModel.trackId.isNilToString()
    }
}
