//
//  SearchArtistTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

final class DownloadSingerTrackUseCase: DownloadSingerTrackUseCaseInterface {
    
    init() {}
    
    func downloadSingerTrack(name: String, completion: @escaping (Result<SingerTrackEntity, ServiceError>) -> ()) {
        let request = SearchSingerTrackAPI()
        let apiLoader = APILoader(apiHandler: request)
        print("Singer Name Downloading ->", name)
        let param: Dictionary<String, Any> = ["limit" : "1", "music" : "media", "term" : name]
    
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(.failure(error!))
            } else {
                let data = model?.toDataEntity().last
                completion(.success(data!))
            }
        }
    }
}