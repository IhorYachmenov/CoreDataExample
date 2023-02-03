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
    }
    
}
