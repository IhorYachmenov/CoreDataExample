//
//  Configurator.swift
//  iTunesSearch
//
//  Created by user on 10.02.2023.
//

import Foundation

final class ViewControllersConfigurator {
    
    class func configureSingerTracks(delegate: SingerTracksDelegate) -> SingerTracksViewController {
        let repository = PersistentStorageRepository()
        
        let search = DownloadSingerTrackUseCase()
        let storage = StorageSingerTracksUseCase(storageRepository: repository)
        let singerTrackWorkerUseCase = SingerTracksWorkerUseCase(useCase: search, useCase: storage)
        
        let viewModel = SingerTracksViewModel(useCase: singerTrackWorkerUseCase)
        
        let viewController = SingerTracksViewController()
        viewController.viewModel = viewModel
        viewController.navigationDelegate = delegate
        
        return viewController
    }
    
    class func configureSingerTrackDetails(delegate: SingerTrackDetailsViewControllerDelegate) -> SingerTrackDetailsViewController {
        let viewController = SingerTrackDetailsViewController()
        viewController.navigationDelegate = delegate
        return viewController
    }
}
