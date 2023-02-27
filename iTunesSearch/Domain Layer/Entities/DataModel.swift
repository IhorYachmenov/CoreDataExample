//
//  DataModel.swift
//  Domain Layer
//
//  Created by user on 27.02.2023.
//

import Foundation
import Data_Layer
import Infrastructure

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
