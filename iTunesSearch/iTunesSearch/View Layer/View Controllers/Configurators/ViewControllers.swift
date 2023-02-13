//
//  Configurator.swift
//  iTunesSearch
//
//  Created by user on 10.02.2023.
//

import Foundation

final class ViewControllers {
    
    class func configureSingerTracks(delegate: SingerTracksDelegate) -> SingerTracksViewController {
        let repository = PersistentStorageRepository()
        
        let search = DownloadSingerTrackUseCase()
        let storage = StorageSingerTracksUseCase(storageRepository: repository)
        let singerTrackWorkerUseCase = SingerTracksWorkerUseCase(useCase: search, useCase: storage)
        
        let viewModel = SingerTracksViewModel(useCase: singerTrackWorkerUseCase)
        
        let viewController = SingerTracksViewController()
        viewController.viewModel = viewModel
        viewController.coordinatorDelegate = delegate
        
        return viewController
    }
    
    class func configureSingerTrackDetails(delegate: SingerTrackDetailsDelegate, trackId: Int) -> SingerTrackDetailsViewController {
        let repository = PersistentStorageRepository()
        
        let storageUseCase = SingerTrackDetailsUseCase(storageRepository: repository)
        
        let viewModel = SingerTrackDetailsViewModel(useCase: storageUseCase)
        
        let viewController = SingerTrackDetailsViewController(trackId: trackId)
        viewController.coodinatorDelegate = delegate
        viewController.viewModel = viewModel
        
        return viewController
    }
}
