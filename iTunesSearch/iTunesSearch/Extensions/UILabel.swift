//
//  UILabel.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import UIKit

extension UILabel {
    func defaultTextAndTitle(text: String) {
        self.text = "\(String(describing: self.text ?? "")) \(text)"
    }
}
