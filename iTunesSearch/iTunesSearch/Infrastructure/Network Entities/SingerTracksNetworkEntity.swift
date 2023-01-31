//
//  ArtistTracks.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

enum NetworkModel {
    struct SingerTracks: Codable {
        let resultCount: Int?
        let results: [SingerTrack]?
    }
    
    struct SingerTrack: Codable {
        let wrapperType: String?
        let kind: String?
        let artistId: Int?
        let collectionId: Int?
        let trackId: Int?
        let artistName: String?
        let collectionName: String?
        let trackName: String?
        let collectionCensoredName: String?
        let trackCensoredName: String?
        let artistViewUrl: String?
        let collectionViewUrl: String?
        let trackViewUrl: String?
        let previewUrl: String?
        let artworkUrl30: String?
        let artworkUrl60: String?
        let artworkUrl100: String?
        let collectionPrice: Float?
        let trackPrice: Float?
        let releaseDate: String?
        let collectionExplicitness: String?
        let trackExplicitness: String?
        let discCount: Int?
        let discNumber: Int?
        let trackCount: Int?
        let trackNumber: Int?
        let trackTimeMillis: Int?
        let country: String?
        let currency: String?
        let primaryGenreName: String?
        let isStreamable: Bool?
        
    }
}











struct SingerTracksNetworkEntity: Codable {
    let resultCount: Int?
    let results: [SingerTrackNetworkEntity]?
}

struct SingerTrackNetworkEntity: Codable {
    
    let wrapperType: String?
    let kind: String?
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Float?
    let trackPrice: Float?
    let releaseDate: String?
    let collectionExplicitness: String?
    let trackExplicitness: String?
    let discCount: Int?
    let discNumber: Int?
    let trackCount: Int?
    let trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?
    
}

extension SingerTracksNetworkEntity {
    func toDataEntity() -> [SingerTrackEntity] {
        return self.results?.map({
            SingerTrackEntity(trackName: $0.trackName.isNil(), singerName: $0.artistName.isNil(), trackPrice: $0.trackPrice.isNilToString(), country: $0.country.isNil())
        }) ?? []
    }
}
