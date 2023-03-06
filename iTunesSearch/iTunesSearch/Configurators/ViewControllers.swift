//
//  Configurator.swift
//  iTunesSearch
//
//  Created by user on 10.02.2023.
//

import Data_Layer
import Domain_Layer
import Infrastructure
import Presentation_Layer

final class ViewControllers {
    class func configureSingerTracks(delegate: SingerTracksDelegate) -> SingerTracksViewController {
        let repository = PersistentStorageRepository()
        
        let singerTrackWorkerUseCase = SingerTracksWorkerUseCase(storageRepository: repository)
        
        let viewModel = SingerTracksViewModel(useCase: singerTrackWorkerUseCase)
        
        let viewController = SingerTracksViewController()
        viewController.viewModel = viewModel
        viewController.coordinatorDelegate = delegate
        
        return viewController
    }
    
    class func configureSingerTrackDetails(delegate: SingerTrackDetailsDelegate, trackId: String) -> SingerTrackDetailsViewController {
        let repository = PersistentStorageRepository()
        let audioClient = AudioClient()
        let imageDownloaderClient = ImageDownloaderClient()
        
        let storageUseCase = SingerTrackDetailsUseCase(storageRepository: repository, imageDownloaderClient: imageDownloaderClient)
        let audioPlayerUseCase = AudioPlayerUseCase(audioClient: audioClient)
        
        let viewModel = SingerTrackDetailsViewModel(trackId: trackId, useCase: storageUseCase, audioPlayerUseCase: audioPlayerUseCase)
        
        let viewController = SingerTrackDetailsViewController()
        viewController.coodinatorDelegate = delegate
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    class func configureSingerTrackMedia(delegate: MediaContentDelegate) -> MediaContentViewController {
        let viewController = MediaContentViewController()
        viewController.coodinatorDelegate = delegate
        
        return viewController
    }
    
    class func configureSingerClip(delegate: SingerClipDelegate) -> SingerClipScreen {
        let viewController = SingerClipScreen()
        viewController.coodinatorDelegate = delegate
        
        return viewController
    }
}
