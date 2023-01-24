//
//  SearchArtistTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

class SearchArtistTracksUseCase {
    
    init() {}
    
    func searchArtistTracks(artistName: String, completion: @escaping (Result<[ArtistsTrackViewEntity], ServiceError>) -> ()) {
        let request = SearchArtistTrackAPI()
        
        var param: Dictionary<String, Any> = [:]
        param.updateValue("100", forKey: "limit")
        param.updateValue("media", forKey: "music")
        param.updateValue(artistName, forKey: "term")
        
        let apiLoader = APILoader(apiHandler: request)
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(.failure(error!))
            } else {
                completion(.success(model?.toDomain() ?? []))
            }
        }
    }
}
