//
//  APILoader.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

public struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    public init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    public func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {
        
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "\(Constants.Error.serviceErrorTitle) \(error?.localizedDescription ?? "\(Constants.Error.unknown)")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "\(Constants.Error.serviceErrorTitle) \(error?.localizedDescription ?? "\(Constants.Error.unknown)")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                         completionHandler(parsedResponse, nil)
                    } catch {
                         completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "\(Constants.Error.serviceErrorTitle) \(error.localizedDescription)"))
                    }
                    
                } else {
                    
                    completionHandler(nil, ServiceError(httpStatus: 0, message: "\(Constants.Error.serviceErrorTitle) \(error?.localizedDescription ?? "\(Constants.Error.unknown)")"))
                }
                
            }.resume()
            
        }
    }
}
