//
//  MediaRouter.swift
//  iTunesSearch
//
//  Created by user on 05.03.2023.
//

import UIKit

//final class MediaRouter: Router {
//    let navigationController: UINavigationController
//
//    init(parentViewController: UIViewController) {
//        self.navigationController = UINavigationController(rootViewController: parentViewController)
//        self.navigationController.navigationBar.tintColor = .oppositeSystemBackgroundColor
//    }
//}

final class NavigationControllerFactory {
    static func navigationController(parentViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: parentViewController)
        navigationController.navigationBar.tintColor = .oppositeSystemBackgroundColor
        
        return navigationController
    }
    
    private init() {}
}
