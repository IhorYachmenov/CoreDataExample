//
//  SingerTrackEntiry.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import Data_Model_Layer

/// **CoreData Entities**
extension DataModel.SingerTrack {
    init(entity: SingerTrack) {
        self.init(
            trackName: entity.trackName.isNil(),
            singerName: entity.singerName.isNil(),
            trackPrice: entity.trackPrice.isNil(),
            country: entity.country.isNil(),
            collectionName: entity.collectionName.isNil(),
            collectionPrice: entity.collectionPrice.isNil(),
            releaseDate: entity.releaseDate.isNil(),
            genre: entity.genre.isNil(),
            demoURL: entity.demoURL.isNil(),
            trackImgURL: entity.trackImgURL.isNil(),
            trackId: entity.trackId.isNil()
        )
    }
}

