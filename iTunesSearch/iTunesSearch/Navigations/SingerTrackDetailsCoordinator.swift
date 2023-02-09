//
//  TrackDetailCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class SingerTrackDetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(id: Int?) {
        let vc = SingerTrackDetailsViewControllerConfigurator.configure(delegate: self)
        vc.trackId = id
        navigationController.pushViewController(vc, animated: true)
    }
}

extension SingerTrackDetailsCoordinator: SingerTrackDetailsViewControllerDelegate {
    
}
