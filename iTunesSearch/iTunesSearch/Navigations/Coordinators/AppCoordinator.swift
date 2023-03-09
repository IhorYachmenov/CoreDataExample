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
    let window: UIWindow
    
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


