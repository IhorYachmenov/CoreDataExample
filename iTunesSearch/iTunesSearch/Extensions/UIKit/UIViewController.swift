//
//  UIViewController.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import UIKit

extension UIViewController {
    func presentAlertController(msg: String, title: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: Constants.Alert.actionButtonTitle, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
