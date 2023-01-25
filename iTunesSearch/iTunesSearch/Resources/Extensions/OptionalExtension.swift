//
//  FloatExtension.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

extension Optional where Wrapped == String {
    
    func isNil() -> String {
        guard self != nil else {
            return ""
        }
        
        return self!
    }
}

extension Optional where Wrapped == Float {
    func isNil() -> Float {
        guard self != nil else {
            return 0
        }
        
        return self!
    }
    
    func isNilToString() -> String {
        guard self != nil else {
            return "0"
        }
        
        return String(self!)
    }
}
