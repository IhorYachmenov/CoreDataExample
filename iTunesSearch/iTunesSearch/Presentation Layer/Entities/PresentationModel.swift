//
//  SingerTrackViewEntity.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

enum PresentationModel {
    struct SingerTrack {
        let trackName: String
        let singerName: String
        let trackPrice: String
        let country: String
        let trackId: String
    }
    
    struct SingerTrackDetail {
        let trackName: String
        let singerName: String
        let collectionName: String
        let collectionPrice: String
        let trackPrice: String
        let releaseDate: String
        let genre: String
        let country: String
        let demoURL: String
        let trackImgURL: String
    }
}

extension PresentationModel.SingerTrackDetail {
    init(dataModel: DataModel.SingerTrack) {
        trackName = dataModel.trackName
        singerName = dataModel.singerName
        collectionName = dataModel.collectionName
        collectionPrice = dataModel.collectionPrice.toDollars
        trackPrice = dataModel.trackPrice.toDollars
        releaseDate = dataModel.releaseDate
        genre = dataModel.genre
        country = dataModel.country
        demoURL = dataModel.demoURL
        trackImgURL = dataModel.trackImgURL
    }
}

extension PresentationModel.SingerTrack {
    init(dataModel: DataModel.SingerTrack) {
        trackName = dataModel.trackName
        singerName = dataModel.singerName
        trackPrice = dataModel.trackPrice
        country = dataModel.country
        trackId = dataModel.trackId
    }
}

