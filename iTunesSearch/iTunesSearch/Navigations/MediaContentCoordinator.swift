//
//  SingerMediaCoordinator.swift
//  iTunesSearch
//
//  Created by user on 05.03.2023.
//

import Foundation
#warning("Як це буде використовуватися!")
final class MediaContentCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    var didFinished: (() -> Void)?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let viewController = Configurator.initializeSingerTrackMedia(delegate: self)
        let mediaRouter = MediaRouter(parentViewController: viewController)
        router.present(mediaRouter.navigationController, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
//            self.removeChild(self)
            self.didFinished?()
        }
    }
}

// MARK: - MediaContentDelegate
extension MediaContentCoordinator: MediaContentDelegate {
    func dismissCoordinator() {
        stop()
    }
    
    func openClipCoordinator() {
        // MARK: - API
        router.pushToChildNavigationController(Configurator.initializeSingerClip(delegate: self))
    }
}

// MARK: - SingerClipDelegate
extension MediaContentCoordinator: SingerClipDelegate {
    func openClip() {
        print("Open Clip Screen")
    }
    
}
