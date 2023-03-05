//
//  String.swift
//  Domain Layer
//
//  Created by user on 27.02.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
