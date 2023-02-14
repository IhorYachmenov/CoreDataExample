//
//  NSMutableAttributedString.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import UIKit

extension NSMutableAttributedString {
    func color(_ color: UIColor, forText textToFind: String) {
        let range = mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(.foregroundColor, value: color, range: range)
        }
    }
    
    func font(_ font: UIFont, forText textToFind: String) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.font, value: font, range: range)
        }
    }
}
