//
//  String.swift
//  Data Model Layer
//
//  Created by user on 02.03.2023.
//

import Foundation

public extension String {
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
