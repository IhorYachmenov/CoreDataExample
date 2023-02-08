//
//  String.swift
//  iTunesSearch
//
//  Created by user on 08.02.2023.
//

import Foundation

extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
}
