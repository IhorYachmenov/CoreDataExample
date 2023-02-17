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
        let collectionName: String
        let collectionPrice: String
        let releaseDate: String
        let genre: String
        let demoURL: String
        let trackImgURL: String
        let trackId: String
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

extension DataModel.SingerTrack {
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
