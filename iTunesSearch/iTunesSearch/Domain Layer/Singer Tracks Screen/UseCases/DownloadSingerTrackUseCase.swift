//
//  SearchArtistTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

final class DownloadSingerTrackUseCase {
    init() {}
}

extension DownloadSingerTrackUseCase: DownloadSingerTrackUseCaseInterface {
    func downloadSingerTrack(name: String, completion: @escaping (Result<DataModel.SingerTrack, ServiceError>) -> ()) {
        let request = SearchSingerTrackAPI()
        let apiLoader = APILoader(apiHandler: request)
        
        let param: Dictionary<String, Any> = ["limit" : "1", "media" : "music", "term" : name]
    
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(.failure(error!))
            } else {
                
                let data = model?.results.map { $0.map { DataModel.SingerTrack(networkModel: $0) } }
                
                if let dataModel = data?.last {
                    completion(.success(dataModel))
                } else {
                    completion(.failure(ServiceError(httpStatus: 0, message: Constants.Error.nilElement)))
                }
            }
        }
    }
}
