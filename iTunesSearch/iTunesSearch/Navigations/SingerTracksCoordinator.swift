//
//  SingerTrackScreenCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

import UIKit

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
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
        }
    }
    #warning("track id naming, naming onDetailCoordinatorFinished, on did")
    #warning("coordinator -> router dependency")
    #warning("Unit tests dependency")
    private func showDetailCoordinator(id: String) {
        // let router = ...
        let detailCoordinator = SingerTrackDetailsCoordinator(router: router, trackId: id)
        coordinate(to: detailCoordinator)
        
        detailCoordinator.onDetailCoordinatorFinished = { [weak self, weak detailCoordinator] in
            guard let self = self else { return }
            guard let index = self.children.firstIndex(where: { $0 === detailCoordinator }) else { return }
            self.children.remove(at: index)
        }
    }
}

// MARK: - Delegate
extension SingerTracksCoordinator: SingerTracksDelegate {
    func coordinator(didSelectTrackWithId: String) {
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
//        coordinator.showDetailCoordinator(id: didSelectTrackWithId)
//    }
//
//}
