//
//  SingerTrackScreenCoordinator.swift
//  iTunesSearch
//
//  Created by user on 06.02.2023.
//

final class SingerTracksCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let singerTracks = Configurator.initializeSingerTracks(delegate: self)
        router.push(singerTracks, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
        }
    }
    
    private func showDetailCoordinator(trackId: String) {
        let detailCoordinator = SingerTrackDetailsCoordinator(router: router, trackId: trackId)
        coordinate(to: detailCoordinator)
        
        detailCoordinator.didFinished = { [weak self, weak detailCoordinator] in
            guard let self = self else { return }
            self.children.removeAll(where: { $0 === detailCoordinator})
        }
    }
}

// MARK: - Delegate
extension SingerTracksCoordinator: SingerTracksDelegate {
    func coordinator(didSelect trackId: String) {
        showDetailCoordinator(trackId: trackId)
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
