//
//  UILabel.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import UIKit

extension UILabel {
    func appendInfoToText(info: String) {
        self.text = "\(String(describing: self.text ?? "")) \(info)"
    }
    
    func attributedInfoToText(info: String, highlightedTextColor: UIColor = .systemGreen) {
        let existingText = self.text ?? ""
        let combinedText = "\(existingText) \(info)"
        
        let attributedString = NSMutableAttributedString(string: combinedText)
        attributedString.color(highlightedTextColor, forText: info)
        attributedString.font(UIFont.boldSystemFont(ofSize: 17), forText: info)
        self.attributedText = attributedString
    }
}

