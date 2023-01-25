//
//  SearchArtistTracksUseCase.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

final class SearchSingerTracksUseCase: SearchSingerTracksUseCaseInterface {
    
    init() {}
    
    func searchSingerTracks(singerName: String, completion: @escaping (Result<[SingerTrackViewEntity], ServiceError>) -> ()) {
        let request = SearchArtistTrackAPI()
        let apiLoader = APILoader(apiHandler: request)
        
        let param: Dictionary<String, Any> = ["limit" : "100", "music" : "media", "term" : singerName]
    
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(.failure(error!))
            } else {
                completion(.success(model?.toDomain() ?? []))
            }
        }
    }
}
