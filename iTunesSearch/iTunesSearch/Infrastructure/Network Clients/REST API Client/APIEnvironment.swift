//
//  APIEnvironment.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return "https://\(domain())\(route())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "itunes.apple.com"
        case .staging:
            return "itunes.apple.com"
        case .production:
            return "itunes.apple.com"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "api"
        }
    }
    
    func route() -> String {
        return "/search"
    }
}
