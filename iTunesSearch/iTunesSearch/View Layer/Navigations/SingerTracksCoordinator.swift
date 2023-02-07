//
//  SingerTrackScreenCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class SingerTracksCoordinator : Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SingerTracksViewControllerConfigurator.configure(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetailPage(){
        let singerTrackDetailsCoordinator = SingerTrackDetailsCoordinator(navigationController: navigationController)
        singerTrackDetailsCoordinator.parentCoordinator = self
        children.append(singerTrackDetailsCoordinator)
        singerTrackDetailsCoordinator.start()
    }
}
