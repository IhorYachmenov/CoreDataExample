//
//  SingerTracksViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 01.02.2023.
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

protocol SingerTracksViewModelInterface {
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())? { get set }
    func downloadSong()
}
