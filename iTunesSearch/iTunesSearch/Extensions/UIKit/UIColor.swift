//
//  UIColor.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import UIKit
extension UIColor {
    static var oppositeSystemBackgroundColor: UIColor {
        let oppositeColor = UIColor { traitCollection in
            if traitCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }
        
        return oppositeColor
    }
}

