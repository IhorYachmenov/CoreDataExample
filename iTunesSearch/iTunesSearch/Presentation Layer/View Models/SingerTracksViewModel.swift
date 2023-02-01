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

#warning("merge data from one moc to another")

#warning("add check dublication")




protocol ViewModelInterface {
    func downloadSong()
    func fetchSongs()
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())? { get set }
}

final class SingerTracksViewModel: ViewModelInterface {
    
   /// MARK - Data Source
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())?
    
    /// MARK: - View Model properties
    private lazy var listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]

    /// MARK: - Use Cases
    private var singerTracksWorker: SingerTracksWorkerUseCaseInterface!
    private var nsfrcUseCase: SubscribeToDataUpdateUseCaseInterface!
    
    init(_ useCase: SingerTracksWorkerUseCaseInterface, _ nsfrc: SubscribeToDataUpdateUseCaseInterface) {
        singerTracksWorker = useCase
        nsfrcUseCase = nsfrc
        
        nsfrcUseCase.subscribeOfData { [weak self] data in
            self?.dataSource?(.success(data.toViewEntity()))
        }
    }
    
    func downloadSong() {
        singerTracksWorker.downloadAndSaveSingerTrack(name: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                self?.dataSource?(.failure(failure))
            }
        }
    }
    
    func fetchSongs() {
        singerTracksWorker.fetchTracksFromStorage { [weak self] result in
            switch result {
            case .success(let success):
                
                let data = success.map{ PresentationModel.SingerTrack(
                    trackName: $0.trackName,
                    singerName: $0.singerName,
                    trackPrice: $0.trackPrice,
                    country: $0.country)
                }
                self?.dataSource?(.success(data))
            case .failure(let failure):
                self?.dataSource?(.failure(failure))
            }
        }
    }
    
}
