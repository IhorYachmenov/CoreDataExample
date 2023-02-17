//
//  String.swift
//  iTunesSearch
//
//  Created by user on 08.02.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    var toDollars: String {
        "$\(self)"
    }
    
    var parceDateFormat: String {
//        let inputExample = "1961-11-11T08:00:00Z"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return self
        }
    }
}
