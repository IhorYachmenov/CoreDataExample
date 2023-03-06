//
//  TrackDetailCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

#warning("Documentation - Optional *")
#warning("move existing tests")

#warning("Implement separate screen from detail screen for testing RouterBuilder")
#warning("** Q: - coordinator -> router dependency, inside showDetailCoordinator")
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
    func openMediaCoordinator() {
        let mediaCoordinator = MediaContentCoordinator(router: router)
        
        mediaCoordinator.didFinished = { [weak self, weak mediaCoordinator] in
                guard let self = self else { return }
                guard let index = self.children.firstIndex(where: { $0 === mediaCoordinator }) else { return }
                self.children.remove(at: index)
        }
        
        children.append(mediaCoordinator)
        mediaCoordinator.start()
    }
    
    func dismissCoordinator() {
        stop()
    }
}
