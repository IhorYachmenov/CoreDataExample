//
//  DependencyFactory.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation

protocol BaseViewModel {
}

protocol ViewModelMaking {
    func make() -> BaseViewModel
}

final class SingerTrackViewModelMaker: ViewModelMaking {
    func make() -> BaseViewModel {
        let repository = PersistentStorageRepository()
        
        let search = DownloadSingerTrackUseCase()
        let storage = StorageSingerTracksUseCase(storageRepository: repository)
        let singerTrackWorkerUseCase = SingerTracksWorkerUseCase(useCase: search, useCase: storage)
        
        let viewModel: SingerTracksViewModelInterface = SingerTracksViewModel(useCase: singerTrackWorkerUseCase)
        
        return viewModel
    }
}

enum DependencyFactory: ViewModelMaking {
    
    case SingerTrackViewModel
    
    func make() -> BaseViewModel {
        switch self {
        case .SingerTrackViewModel:
            return SingerTrackViewModelMaker().make()
        }
    }
}
