//
//  AppCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

// MARK: - App Coordinator
final class AppCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    private let window: UIWindow
    
    init(window: UIWindow, router: Router) {
        self.window = window
        self.router = router
        
        setupWindow()
    }
    
    func start() {
        let singerTracksCoordinator = SingerTracksCoordinator(router: router)
        coordinate(to: singerTracksCoordinator)
    }
    
    func stop() {
        // -
    }
}

extension AppCoordinator {
    private func setupWindow() {
        window.rootViewController = router.coordinatorComponent.navigationController
        window.makeKeyAndVisible()
    }
}

// MARK: - Coordinator Components
class CoordinatorComponents {
    fileprivate let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.tintColor = .oppositeSystemBackgroundColor
    }
}

// MARK: - Router Extension
extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        if (coordinatorComponent.navigationController.presentedViewController != nil) {
            let presendViewController = coordinatorComponent.navigationController.presentedViewController
            presendViewController?.present(viewController, animated: true)
            return
        }
        coordinatorComponent.navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        coordinatorComponent.navigationController.dismiss(animated: animated) {
            completion?()
        }
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        if (coordinatorComponent.navigationController.presentedViewController != nil) {
            let childNavigationController = coordinatorComponent.navigationController.presentedViewController as? UINavigationController
            childNavigationController?.pushViewController(viewController, animated: true)
            return
        }
        coordinatorComponent.navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        // Exist capability to add pop to the root or not UINavigationController
        //        if (navigationController.presentedViewController != nil) {
        //            let childNavigationController = navigationController.presentedViewController as? UINavigationController
        //            childNavigationController?.popViewController(animated: animated)
        //            return
        //        }
        coordinatorComponent.navigationController.popViewController(animated: animated)
    }
}
