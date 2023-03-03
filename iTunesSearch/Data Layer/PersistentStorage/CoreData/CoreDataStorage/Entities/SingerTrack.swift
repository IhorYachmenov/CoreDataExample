//
//  SingerTrackMO.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData
import Data_Model_Layer

extension SingerTrack {
    convenience init(query: DataModel.SingerTrack, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        
        trackName = query.trackName
        singerName = query.singerName
        trackPrice = query.trackPrice
        country = query.country
        collectionName = query.collectionName
        collectionPrice = query.collectionPrice
        releaseDate = query.releaseDate
        genre = query.genre
        demoURL = query.demoURL
        trackImgURL = query.trackImgURL
        trackId = query.trackId
    }
}

