//
//  SearchArtistTrack.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation
import Data_Transfer_Objects

public struct SearchSingerTrackAPI: APIHandler {
    public func makeRequest(from param: [String: Any]) -> URLRequest? {
        let urlString = APIPath().singerTrackSearchPath
        if var url = URL(string: urlString) {
            if param.count > 0 {
//                print(param.description)
                url = setQueryParams(parameters: param, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
//            urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: param, options: .init())
            return urlRequest
        }
        return nil
    }
    
    public func parseResponse(data: Data, response: HTTPURLResponse) throws -> NetworkModel.SingerTracks {
        return try defaultParseResponse(data: data, response: response)
    }
    
    public init() {}
}
