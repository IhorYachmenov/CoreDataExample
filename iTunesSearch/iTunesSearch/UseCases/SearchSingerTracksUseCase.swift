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
        let request = SearchSingerTrackAPI()
        let apiLoader = APILoader(apiHandler: request)
        print("Singer Name Donloading ->", singerName)
        let param: Dictionary<String, Any> = ["limit" : "1", "music" : "media", "term" : singerName]
    
        apiLoader.loadAPIRequest(requestData: param) { (model, error) in
            if let _ = error {
                completion(.failure(error!))
            } else {
                completion(.success(model?.toDomain() ?? []))
            }
        }
    }
}
