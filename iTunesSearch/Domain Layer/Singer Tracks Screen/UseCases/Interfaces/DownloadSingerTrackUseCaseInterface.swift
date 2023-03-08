//
//  SearchSingerTracksUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import Data_Model_Layer
import Infrastructure

public extension DTO.SingerTrack {
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

protocol DownloadSingerTrackUseCaseInterface {
    func downloadSingerTrack(name: String, completion: @escaping (Result<DTO.SingerTrack, Error>) -> ())
}
