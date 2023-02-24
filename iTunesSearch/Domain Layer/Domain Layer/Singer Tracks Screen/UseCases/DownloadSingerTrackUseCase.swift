//
//  SearchArtistTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Data_Layer
import Infrastructure

public final class DownloadSingerTrackUseCase {
    public init() {}
}

extension DownloadSingerTrackUseCase: DownloadSingerTrackUseCaseInterface {
    public func downloadSingerTrack(name: String, completion: @escaping (Result<DataModel.SingerTrack, ServiceError>) -> ()) {
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
                    completion(.failure(NSError.error(msg: Constants.Error.nilElement) as! ServiceError))
                }
            }
        }
    }
}
