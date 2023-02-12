//
//  SingerTrackScreenCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit
#warning("Testing navigation")

class SingerTracksCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let singerTracksViewController = ViewControllers.configureSingerTracks(delegate: self)
        router.push(singerTracksViewController, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) {
            self.removeChild(self)
        }
    }
    
    private func showDetailCoordinator(id: Int) {
        let detailCoordinator = SingerTrackDetailsCoordinator(router: router, id: id)
        coordinate(to: detailCoordinator)
        
        detailCoordinator.onDetailCoordinatorFinished = { [weak self] in
            guard let index = self?.children.firstIndex(where: { $0 === detailCoordinator }) else { return }
            self?.children.remove(at: index)
        }
    }
}

// MARK: - Delegate
extension SingerTracksCoordinator: SingerTracksDelegate {
    func coordinator(didSelectTrackWithId: Int) {
        showDetailCoordinator(id: didSelectTrackWithId)
    }
}
