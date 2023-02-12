//
//  AppCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var children: [Coordinator] = []
    private let window: UIWindow
    let router: Router
    
    init(window: UIWindow, router: Router) {
        self.window = window
        self.router = router
    }
    
    func start() {
        let singerTracksCoordinator = SingerTracksCoordinator(router: router)
        coordinate(to: singerTracksCoordinator)
        
        setupWindow()
    }
    
    func stop() {
        // -
    }
}

extension AppCoordinator {
    func setupWindow() {
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}
