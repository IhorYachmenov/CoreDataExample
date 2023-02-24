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
        let singerTracks = ViewControllers.configureSingerTracks(delegate: self)
        router.push(singerTracks, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
        }
    }
#warning("** Q: - coordinator -> router dependency, inside showDetailCoordinator")
#warning("docC")
#warning("downloadAndSaveSingerTrack <- , naming observe etc., example SingerTracksWorkerUseCaseInterface")
#warning("Use case API link SingerTracksWorkerUseCase")
#warning("separate model module ?, data entities")
#warning("swift only frameworks, objc+swift, umbrella..., module.modulemap, cocoapods")
#warning("Error, StorageError")
#warning("module name reversing, is layers com.....")
    
    private func showDetailCoordinator(trackId: String) {
        //        let router = RounterBuilder.makerRouter(type: .PlayerScreenRouter)
        let detailCoordinator = SingerTrackDetailsCoordinator(router: router, trackId: trackId)
        coordinate(to: detailCoordinator)
        
        detailCoordinator.didFinished = { [weak self, weak detailCoordinator] in
            guard let self = self else { return }
            guard let index = self.children.firstIndex(where: { $0 === detailCoordinator }) else { return }
            self.children.remove(at: index)
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
