//
//  SingerMediaCoordinator.swift
//  iTunesSearch
//
//  Created by user on 05.03.2023.
//

import Foundation
import UIKit

final class MediaContentCoordinator: Coordinator {
    var children: [Coordinator] = []
    let router: Router
    private var mediaRouter: Router!
    var didFinished: (() -> Void)?
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        mediaRouter = MediaRouter(parentViewController: ViewControllers.configureSingerTrackMedia(delegate: self))
        router.present(mediaRouter.navigationController, animated: true)
    }
    
    func stop() {
        router.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.removeChild(self)
            self.didFinished?()
        }
    }
}

extension MediaContentCoordinator: MediaContentDelegate {
    func dismissCoordinator() {
        print("Dismiss Media")
        stop()
    }
    
    func openClipCoordinator() {
        mediaRouter.navigationController.pushViewController(SingerClipScreen(), animated: true)
    }
}
