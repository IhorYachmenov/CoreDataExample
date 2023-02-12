//
//  Router.swift
//  iTunesSearch
//
//  Created by user on 08.02.2023.
//

import UIKit

protocol Router: AnyObject {
    var navigationController: UINavigationController { get }
    
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        navigationController.present(viewController, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated) {
            completion?()
        }
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}

