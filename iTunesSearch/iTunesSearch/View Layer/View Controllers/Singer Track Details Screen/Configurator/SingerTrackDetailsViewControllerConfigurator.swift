//
//  SingerTrackDetailsViewControllerConfigurator.swift
//  iTunesSearch
//
//  Created by user on 07.02.2023.
//

import Foundation

class SingerTrackDetailsViewControllerConfigurator {
    class func configure(coordinator: SingerTrackDetailsCoordinator) -> SingerTrackDetailsViewController {
        let viewController = SingerTrackDetailsViewController()
        viewController.coordinator = coordinator
        
        return viewController
    }
}
