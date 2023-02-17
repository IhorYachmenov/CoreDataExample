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
        static let coreDataSaving = "Can't save data to data base".localized
        static let nilElement = "Element a nil".localized
        static let serviceErrorTitle = "Service Error:".localized
        static let unknown = "Unknown Error".localized
        static let dataNotFound = "Data not found".localized
    }
}
