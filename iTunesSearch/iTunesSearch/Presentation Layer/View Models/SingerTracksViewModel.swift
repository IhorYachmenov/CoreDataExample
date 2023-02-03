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


final class SingerTracksViewModel: SingerTracksViewModelInterface {
    
   /// MARK - Data Source
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())?
    
    /// MARK: - View Model properties
    private lazy var listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]

    /// MARK: - Use Cases
    private var singerTracksWorker: SingerTracksWorkerUseCaseInterface!
    
    init(_ useCase: SingerTracksWorkerUseCaseInterface, _ dataSubscriber: DataSubscriberUseCaseInterface) {
        singerTracksWorker = useCase
        
        dataSubscriber.subscribeOfData { [weak self] data in
            DispatchQueue.main.async {
                self?.dataSource?(.success(data.toViewEntity()))
            }
        }
    }
    
    func downloadSong() {
        singerTracksWorker.downloadAndSaveSingerTrack(name: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.dataSource?(.failure(failure))
                }
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
