//
//  APIPath.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

#if DEBUG
let environment = APIEnvironment.development
#else
let environment = APIEnvironment.production
#endif

let baseURL = environment.baseURL()

struct APIPath {
    var player: String { return "\(baseURL)" }
}
