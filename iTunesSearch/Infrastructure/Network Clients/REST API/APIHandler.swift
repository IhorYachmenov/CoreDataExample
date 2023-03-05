//
//  APIHandler.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

// MARK: APIHandler
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data: RequestDataType) -> URLRequest?
}

public protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> ResponseDataType
}

public typealias APIHandler = RequestHandler & ResponseHandler

