//
//  RequestHandler+Extension.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

// MARK: Response Handler - parse default
public struct ServiceError: Error, Codable {
    let httpStatus: Int
    let message: String
}

extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "\(Constants.Error.RESTapi.unknown)")
            }
        } catch  {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}
