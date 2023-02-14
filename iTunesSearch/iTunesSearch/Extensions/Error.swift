//
//  Error.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import Foundation

extension NSError {
    static func error(msg: String) -> Error {
        NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])
    }
}
