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
    private var trackId: String
    var didFinished: (() -> Void)?
    
    init(router: Router, trackId: String) {
        self.router = router
        self.trackId = trackId
    }
    
    func start() {
        let singerTrackDetails = ViewControllers.configureSingerTrackDetails(delegate: self, trackId: trackId)
        router.push(singerTrackDetails, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
            self.didFinished?()
        }
    }
}

// MARK: - Delegate
extension SingerTrackDetailsCoordinator: SingerTrackDetailsDelegate {
    func dismissCoordinator() {
        stop()
    }
}
