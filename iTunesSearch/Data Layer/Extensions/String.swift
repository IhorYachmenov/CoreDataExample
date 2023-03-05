//
//  String.swift
//  Data Layer
//
//  Created by user on 21.02.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
