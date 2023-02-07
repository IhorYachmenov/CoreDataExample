//
//  AppCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSingerTracksListScreen()
    }
    
    func showSingerTracksListScreen(){
        let singerTracksCoordinator = SingerTracksCoordinator.init(navigationController: navigationController)
        singerTracksCoordinator.parentCoordinator = self
        children.append(singerTracksCoordinator)
        singerTracksCoordinator.start()
    }
}


