//
//  String.swift
//  Presentation Layer
//
//  Created by user on 27.02.2023.
//

import Foundation

extension String {
//    var localized: String {
//        NSLocalizedString(self, comment: "")
//    }
    
    var toDollars: String {
        "$\(self)"
    }
}
