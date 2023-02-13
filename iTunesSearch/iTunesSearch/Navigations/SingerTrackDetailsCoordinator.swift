//
//  TrackDetailCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

class SingerTrackDetailsCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    var id: Int
    var onDetailCoordinatorFinished: (() -> Void)?
    
    init(router: Router, id: Int) {
        self.router = router
        self.id = id
    }
    
    func start() {
        let singerTrackDetails = ViewControllers.configureSingerTrackDetails(delegate: self)
        router.push(singerTrackDetails, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
            self.onDetailCoordinatorFinished?()
        }
    }
}

// MARK: - Delegate
extension SingerTrackDetailsCoordinator: SingerTrackDetailsDelegate {
    func dismissCoordinator() {
        stop()
    }
}
