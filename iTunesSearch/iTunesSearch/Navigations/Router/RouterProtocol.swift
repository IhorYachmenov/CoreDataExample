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
        if (navigationController.presentedViewController != nil) {
            let presendViewController = navigationController.presentedViewController
            presendViewController?.present(viewController, animated: true)
            return
        }
        navigationController.present(viewController, animated: animated, completion: nil)
    }

    func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated) {
            completion?()
        }
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        if (navigationController.presentedViewController != nil) {
            let childNavigationController = navigationController.presentedViewController as? UINavigationController
            childNavigationController?.pushViewController(viewController, animated: true)
            return
        }
        navigationController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool) {
        // Exist capability to add pop to the root or not UINavigationController
//        if (navigationController.presentedViewController != nil) {
//            let childNavigationController = navigationController.presentedViewController as? UINavigationController
//            childNavigationController?.popViewController(animated: animated)
//            return
//        }
        navigationController.popViewController(animated: animated)
    }
}

