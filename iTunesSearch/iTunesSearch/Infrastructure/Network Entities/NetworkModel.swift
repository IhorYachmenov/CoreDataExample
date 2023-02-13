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

extension NetworkModel.SingerTracks {
    func toDataEntity() -> [DataModel.SingerTrack] {
        let data = self.results ?? []
        return data.map {
            DataModel.SingerTrack(
                trackName: $0.trackName.isNil(),
                singerName: $0.artistName.isNil(),
                trackPrice: $0.trackPrice.isNilToString(),
                country: $0.country.isNil(),
                collectionName: $0.collectionName.isNil(),
                collectionPrice: $0.collectionPrice.isNilToString(),
                releaseDate: $0.releaseDate.isNil(),
                genre: $0.primaryGenreName.isNil(),
                demoURL: $0.previewUrl.isNil(),
                trackImgURL: $0.artworkUrl100.isNil(),
                trackID: $0.trackId.isNilToString()
            )
        }
    }
}
