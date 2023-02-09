//
//  SingerTrackDetailsViewControllerConfigurator.swift
//  iTunesSearch
//
//  Created by user on 07.02.2023.
//

import Foundation

class SingerTrackDetailsViewControllerConfigurator {
    class func configure(delegate: SingerTrackDetailsViewControllerDelegate) -> SingerTrackDetailsViewController {
        let viewController = SingerTrackDetailsViewController()
        viewController.navigationDelegate = delegate
        return viewController
    }
}
