//
//  SingerTracksViewControllerConfigurator.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation

class SingerTracksViewControllerConfigurator {
    class func configure(coordinator: SingerTracksCoordinator) -> SingerTracksViewController {
        let repository = PersistentStorageRepository()
        
        let search = DownloadSingerTrackUseCase()
        let storage = StorageSingerTracksUseCase(storageRepository: repository)
        let singerTrackWorkerUseCase = SingerTracksWorkerUseCase(useCase: search, useCase: storage)
        
        let viewModel = SingerTracksViewModel(useCase: singerTrackWorkerUseCase)
        
        let viewController = SingerTracksViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        
        return viewController
    }
}
