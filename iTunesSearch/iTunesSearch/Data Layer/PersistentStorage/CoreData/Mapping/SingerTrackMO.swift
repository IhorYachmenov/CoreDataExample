//
//  SingerTrackMO.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

extension SingerTrackMO {
    convenience init(query: SingerTrackEntity, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        
        trackName = query.trackName
        singerName = query.singerName
        trackPrice = query.trackPrice
        country = query.country
    }
    
}

extension SingerTrackMO {
    func toData() -> SingerTrackEntity {
        return .init(trackName: trackName.isNil(), singerName: singerName.isNil(), trackPrice: trackPrice.isNil(), country: country.isNil())
    }
}
