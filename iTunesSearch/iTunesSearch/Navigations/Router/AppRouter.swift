//
//  AppRouter.swift
//  iTunesSearch
//
//  Created by user on 12.02.2023.
//

import UIKit

final class AppRouter: Router {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = .oppositeSystemBackgroundColor
    }
}
