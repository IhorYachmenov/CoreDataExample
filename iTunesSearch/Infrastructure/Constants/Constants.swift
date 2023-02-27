//
//  Constants.swift
//  Infrastructure
//
//  Created by user on 21.02.2023.
//

import Foundation

struct Constants {
    struct Error {
        struct ImageClient {
            static let urlEmpty = "Demo-URL-corrupted"
            static let notValidUrl = ""
            static let downloadingError = ""
            static let dataCorrupted = ""
        }
        struct TrackDownloaderClient {
            static let urlEmpty = "Demo-URL-corrupted"
            static let notValidUrl = ""
            static let fileSystemUrlNotExist = ""
        }
        struct RESTapi {
            static let urlResponceNil = "Server-error-while-downloading-image"
            static let requestDataNil = ""
            static let parsingProblem = ""
            static let unknown = "Unknown-error"
        }
    }
}
