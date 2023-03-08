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
    private var mediaRouter: Router!
    var didFinished: (() -> Void)?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        #warning("Naming, router api inside viewWill...")
        mediaRouter = MediaRouter(parentViewController: Configurator.initializeSingerTrackMedia(delegate: self))
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
        mediaRouter.navigationController.pushViewController(Configurator.initializeSingerClip(delegate: self), animated: true)
    }
}

// MARK: - SingerClipDelegate
extension MediaContentCoordinator: SingerClipDelegate {
    func clipScreenDidDismissed() {
        stop()
    }
    
}
