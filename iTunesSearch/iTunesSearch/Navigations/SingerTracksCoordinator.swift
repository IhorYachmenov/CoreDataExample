//
//  SingerTrackScreenCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

protocol SingerTracksDelegate: AnyObject {
    func userDidPressTrackCell(id: Int)
}

class SingerTracksCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(id: Int?) {
        let vc = SingerTracksViewControllerConfigurator.configure(delegate: self)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension SingerTracksCoordinator: SingerTracksDelegate {
    func userDidPressTrackCell(id: Int) {
        showTrackDetails(id: id)
    }
    
    private func showTrackDetails(id: Int) {
        let singerTrackDetailsCoordinator = SingerTrackDetailsCoordinator(navigationController: navigationController)
        singerTrackDetailsCoordinator.start(id: id)
    }
}
