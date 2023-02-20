//
//  DownloadSingerTrackUseCaseMoc.swift
//  iTunesSearchTests
//
//  Created by user on 20.02.2023.
//

@testable import iTunesSearch

final class DownloadSingerTrackUseCaseMoc {
    init() {}
}

extension DownloadSingerTrackUseCaseMoc: DownloadSingerTrackUseCaseInterface {
    func downloadSingerTrack(name: String, completion: @escaping (Result<iTunesSearch.DataModel.SingerTrack, iTunesSearch.ServiceError>) -> ()) {
        let dataModel = DataModel.SingerTrack(
            trackName: "Rommance",
            singerName: "Lady Gaga",
            trackPrice: "9.99",
            country: "USA",
            collectionName: "Test Collection",
            collectionPrice: "9.99",
            releaseDate: "-",
            genre: "-",
            demoURL: "_",
            trackImgURL: "-",
            trackId: "0001")
        completion(.success(dataModel))
    }
}
