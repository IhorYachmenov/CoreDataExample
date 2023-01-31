//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

//protocol ViewModel {
//    associatedtype Model: Equatable
//    var model: Observable<Model>? { get }
//    //func observeModel(completion: (Model) -> Void)
//    func updateData()
//}

enum ViewModelActionState {
    case inProgress
    case completed
    case failure(Error)
}

#warning("rewrite interface of view model")

#warning("add check dublication")

#warning("Name Space")

#warning("merge data from one moc to another")

class SingerTracksViewModel {
    
    /// MARK: - View Model data
    private(set) var data: Array<SingerTrackViewEntity> = Array()
    private lazy var listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]
    
    /// MARK: - Data Source
    var dataSource: ((ViewModelActionState) ->())?
    
    /// MARK: - Data Provider
    private var singerTracksWorker: SingerTracksWorkerUseCaseInterface
    
    // MARK: - Init
    init(_ useCase: SingerTracksWorkerUseCaseInterface) {
        singerTracksWorker = useCase
    }
    
    func downloadRandomSingerTrack() {
        dataSource?(.inProgress)
        
        singerTracksWorker.downloadAndSaveSingerTrack(name: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(_):
                self?.dataSource?(.completed)
            case .failure(let failure):
                self?.dataSource?(.failure(failure))
            }
        }
    }

    func fetchListOfSongsFromStorage() {
       
        singerTracksWorker.fetchTracksFromStorage { [weak self] result in
            switch result {
            case .success(let success):
                
                self?.data = success.map{ SingerTrackViewEntity(
                    trackName: $0.trackName,
                    singerName: $0.singerName,
                    trackPrice: $0.trackPrice,
                    country: $0.country)
                }
                
                self?.dataSource?(.completed)
            case .failure(let failure):
                self?.dataSource?(.failure(failure))
            }
        }
    }
    
}
