//
//  SingerTrackDetailsViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

extension PresentationModel {
    struct SingerTrackDetails {
        var details: Details?
        var track: Track?
        
        struct Details {
            let trackName: String
            let singerName: String
            let collectionName: String
            let collectionPrice: String
            let trackPrice: String
            let releaseDate: String
            let genre: String
            let country: String
            var image: Data?
        }
        
        struct Track {
            let currentTime: String
            let duration: String
            let isPlaying: Bool
            let progress: Float
        }
    }
    
}

extension PresentationModel.SingerTrackDetails.Details {
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

extension PresentationModel.SingerTrackDetails.Track {
    init(mediaModel: MediaModel.AudioData) {
        currentTime = mediaModel.currentTime
        duration = mediaModel.duration
        isPlaying = mediaModel.isPlaying
        progress = mediaModel.progress
    }
}

protocol SingerTrackDetailsViewModelInterface {
    var dataSource: ((Result<PresentationModel.SingerTrackDetails, Error>) -> ())? { get set }
    func playTrack()
}
