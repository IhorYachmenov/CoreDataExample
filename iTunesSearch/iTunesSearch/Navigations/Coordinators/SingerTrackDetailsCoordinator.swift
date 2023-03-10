//
//  TrackDetailCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

#warning("Documentation - Optional *")
#warning("move existing tests")

final class SingerTrackDetailsCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    var didFinished: (() -> Void)?
    private var trackId: String
    
    init(router: Router, trackId: String) {
        self.router = router
        self.trackId = trackId
    }
    
    func start() {
        let singerTrackDetails = Configurator.initializeSingerTrackDetails(delegate: self, trackId: trackId)
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
    func openMediaCoordinator() {
        let mediaCoordinator = MediaContentCoordinator(router: router)
        coordinate(to: mediaCoordinator)

        mediaCoordinator.didFinished = { [weak self, weak mediaCoordinator] in
            guard let self = self else { return }
            self.children.removeAll(where: { $0 === mediaCoordinator})
        }
    }
    
    func dismissCoordinator() {
        stop()
    }
}
