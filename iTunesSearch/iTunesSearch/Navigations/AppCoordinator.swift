//
//  AppCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

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
        window.rootViewController = router.navigationController
        window.makeKeyAndVisible()
    }
}
