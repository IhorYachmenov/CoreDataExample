//
//  APILoader.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

struct APILoader<T: APIHandler> {
    var apiHandler: T
    var urlSession: URLSession
    
    init(apiHandler: T, urlSession: URLSession = .shared) {
        self.apiHandler = apiHandler
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completionHandler: @escaping (T.ResponseDataType?, ServiceError?) -> ()) {
        
        if let urlRequest = apiHandler.makeRequest(from: requestData) {
            urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    guard error == nil else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "\(Constants.Error.serviseErrorTitle) \(error?.localizedDescription ?? "\(Constants.Error.unknownError)")"))
                        return
                    }
                    
                    guard let responseData = data else {
                        completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "\(Constants.Error.serviseErrorTitle) \(error?.localizedDescription ?? "\(Constants.Error.unknownError)")"))
                        return
                    }
                    
                    do {
                        let parsedResponse = try self.apiHandler.parseResponse(data: responseData, response: httpResponse)
                         completionHandler(parsedResponse, nil)
                    } catch {
                         completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "\(Constants.Error.serviseErrorTitle) \(error.localizedDescription)"))
                    }
                    
                } else {
                    
                    completionHandler(nil, ServiceError(httpStatus: 0, message: "\(Constants.Error.serviseErrorTitle) \(error?.localizedDescription ?? "\(Constants.Error.unknownError)")"))
                }
                
            }.resume()
            
        }
    }
}
