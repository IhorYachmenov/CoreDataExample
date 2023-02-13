//
//  SingerTrackMO.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

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

extension SingerTrack {
    func toDataEntity() -> DataModel.SingerTrack {
        return .init(
            trackName: trackName.isNil(),
            singerName: singerName.isNil(),
            trackPrice: trackPrice.isNil(),
            country: country.isNil(),
            collectionName: collectionName.isNil(),
            collectionPrice: collectionPrice.isNil(),
            releaseDate: releaseDate.isNil(),
            genre: genre.isNil(),
            demoURL: demoURL.isNil(),
            trackImgURL: trackImgURL.isNil(),
            trackId: trackId.isNil()
        )
    }
}
