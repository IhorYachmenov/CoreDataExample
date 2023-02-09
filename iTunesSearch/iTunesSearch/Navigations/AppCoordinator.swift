//
//  AppCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(id: Int?) {
        showSingerTracksListScreen()
    }
    
    func showSingerTracksListScreen() {
        let singerTracksCoordinator = SingerTracksCoordinator.init(navigationController: navigationController)
        singerTracksCoordinator.start(id: nil)
    }
}


