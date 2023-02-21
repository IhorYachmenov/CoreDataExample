//
//  NSError.swift
//  Domain Layer
//
//  Created by user on 21.02.2023.
//

import Foundation

extension NSError {
    static func error(msg: String) -> Error {
        NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])
    }
}
