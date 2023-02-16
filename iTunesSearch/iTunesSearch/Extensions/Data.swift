//
//  UIImage.swift
//  iTunesSearch
//
//  Created by user on 16.02.2023.
//

import UIKit

extension Data {
    var image: UIImage? {
        UIImage(data: self)
    }
}
