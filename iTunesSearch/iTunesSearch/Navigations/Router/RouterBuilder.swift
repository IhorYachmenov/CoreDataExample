//
//  RouterBuilder.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import UIKit

protocol RouterFactory: Router {
    // Something additional, or delete this protocol
}

final class DetailScreenRouter: RouterFactory {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

final class PlayerScreenRouter: RouterFactory {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

enum RouterType {
    case DefaultRouter
    case DetailScreenRouter
    case PlayerScreenRouter
}

enum RounterBuilder {
    static func makerRouter(type: RouterType) -> Router {
        switch type {
        case .DefaultRouter:
            return AppRouter(navigationController: UINavigationController())
        case .DetailScreenRouter:
            return DetailScreenRouter(navigationController: UINavigationController())
        case .PlayerScreenRouter:
            return PlayerScreenRouter(navigationController: UINavigationController())
        }
    }
}
