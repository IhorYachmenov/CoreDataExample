//
//  SingerTracksViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 01.02.2023.
//

import Foundation
import Data_Model_Layer

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
    init(dataModel: DTO.SingerTrack) {
        trackName = dataModel.trackName
        singerName = dataModel.singerName
        trackPrice = dataModel.trackPrice.toDollars
        country = dataModel.country
        trackId = dataModel.trackId
    }
}

public  protocol SingerTracksViewModelInterface {
    var observeData: ((Result<[PresentationModel.SingerTrack], Error>) -> ())? { get set }
    func downloadSong()
}
