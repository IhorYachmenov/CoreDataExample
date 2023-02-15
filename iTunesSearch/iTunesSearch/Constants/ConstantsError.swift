//
//  ConstantsError.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation
extension Constants {
    struct Error {
        static let downloadingImage = "Server error while downloading image".localized
        static let corruptingData = "Download was successful but data corrupted".localized
        static let coreDataSave = "Wrong Entity name 😱".localized
        static let nilElement = "Server error element a nil".localized
        static let serviseErrorTitle = "Service Error:".localized
        static let unknownError = "Unknown Error".localized
    }
}
