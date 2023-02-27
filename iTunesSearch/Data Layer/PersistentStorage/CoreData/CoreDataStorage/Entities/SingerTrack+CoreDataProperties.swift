//
//  SingerTrack+CoreDataProperties.swift
//  Data Layer
//
//  Created by user on 22.02.2023.
//
//

import Foundation
import CoreData


extension SingerTrack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingerTrack> {
        return NSFetchRequest<SingerTrack>(entityName: "SingerTrack")
    }

    @NSManaged public var collectionName: String?
    @NSManaged public var collectionPrice: String?
    @NSManaged public var country: String?
    @NSManaged public var demoURL: String?
    @NSManaged public var genre: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var singerName: String?
    @NSManaged public var trackId: String?
    @NSManaged public var trackImgURL: String?
    @NSManaged public var trackName: String?
    @NSManaged public var trackPrice: String?

}

//extension SingerTrack : Identifiable {
//
//}
