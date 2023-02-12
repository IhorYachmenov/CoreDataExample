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
        let singerTracks = ViewControllers.configureSingerTracks(delegate: self)
        router.push(singerTracks, animated: true)
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
            guard let self = self else { return }
            guard let index = self.children.firstIndex(where: { $0 === detailCoordinator }) else { return }
            self.children.remove(at: index)
        }
    }
}

// MARK: - Delegate
extension SingerTracksCoordinator: SingerTracksDelegate {
    func coordinator(didSelectTrackWithId: Int) {
        showDetailCoordinator(id: didSelectTrackWithId)
    }
}

//class SingerTracksDelegateImpl: SingerTracksDelegate {
//
//    let coordinator: SingerTracksCoordinator
//
//    init(coordinator: SingerTracksCoordinator) {
//        self.coordinator = coordinator
//    }
//
//    func coordinator(didSelectTrackWithId: Int) {
//        coordinator.showDetailCoordinator(id: id)
//    }
//
//}
