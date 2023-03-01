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
            static let urlEmpty = "Image-Client-Url-Empty".localized
            static let notValidUrl = "Image-Client-Not-Valid-Url".localized
            static let downloadingError = "Image-Client-Downloading-Error".localized
            static let dataCorrupted = "Image-Client-Data-Corrupted".localized
        }
        struct TrackDownloaderClient {
            static let urlEmpty = "Track-Downloader-Client-UrlEmpty".localized
            static let notValidUrl = "Track-Downloader-Client-Not-Valid-Url".localized
            static let fileSystemUrlNotExist = "Track-Downloader-Client-File-System-Url-Not-Exist".localized
        }
        struct RESTapi {
            static let urlResponceNil = "Rest-Api-Url-Responce-Nil".localized
            static let requestDataNil = "Rest-Api-Request-Data-Nil".localized
            static let parsingProblem = "Rest-Api-Parsing-Problem".localized
            static let unknown = "Rest-Api-Unknown".localized
        }
    }
}
