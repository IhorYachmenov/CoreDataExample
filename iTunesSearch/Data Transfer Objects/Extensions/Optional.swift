//
//  Optional.swift
//  Data Model Layer
//
//  Created by user on 03.03.2023.
//

import Foundation

public extension Optional where Wrapped == String {
    func isNil() -> String {
        guard self != nil else { return "-" }
        return self!.isEmpty ? "-" : self!
    }
}

public extension Optional where Wrapped == Float {
    func isNil() -> Float {
        guard self != nil else { return 0 }
        return self!
    }
    
    func isNilToString() -> String {
        guard self != nil else { return "0" }
        return String(self!)
    }
}

public extension Optional where Wrapped == Int {
    func isNil() -> Int {
        guard self != nil else { return 0 }
        return self!
    }
    
    func isNilToString() -> String {
        guard self != nil else { return "0" }
        return String(self!)
    }
}
