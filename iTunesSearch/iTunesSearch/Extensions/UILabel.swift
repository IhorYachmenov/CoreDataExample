//
//  UILabel.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import UIKit

extension UILabel {
    func appentText(defaultText: String?, text: String?) {
        self.text = "\(String(describing: defaultText ?? "")) \(text ?? "")"
    }
    
    func attributedText(defaultText: String?, text: String?, highlightedTextColor: UIColor = .systemGreen) {
        let existingText = defaultText ?? ""
        let info = text ?? ""
        let combinedText = "\(existingText) \(info)"
        
        let attributedString = NSMutableAttributedString(string: combinedText)
        attributedString.color(highlightedTextColor, forText: info)
        attributedString.font(UIFont.boldSystemFont(ofSize: 17), forText: info)
        self.attributedText = attributedString
    }
}

