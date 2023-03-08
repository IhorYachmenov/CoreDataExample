//
//  SearchArtistTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation
import Data_Layer
import Infrastructure
import Data_Transfer_Objects

final class DownloadSingerTrackUseCase {
    init() {}
}

extension DownloadSingerTrackUseCase: DownloadSingerTrackUseCaseInterface {
    func downloadSingerTrack(name: String, completion: @escaping (Result<DTO.SingerTrack, Error>) -> ()) {
        let request = SearchSingerTrackAPI()
        let apiLoader = APILoader(apiHandler: request)
        
        let param: Dictionary<String, Any> = ["limit" : "1", "media" : "music", "term" : name]
    
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                
                let data = model?.results.map { $0.map { DTO.SingerTrack(networkModel: $0) } }
                
                if let dataModel = data?.last {
                    completion(.success(dataModel))
                } else {
                    completion(.failure(NSError.error(msg: Constants.Error.DownloadSingerTrackUseCase.nilData)))
                }
            }
        }
    }
}
