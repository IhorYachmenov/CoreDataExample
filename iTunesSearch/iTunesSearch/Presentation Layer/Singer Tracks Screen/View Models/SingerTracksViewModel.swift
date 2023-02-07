//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

final class SingerTracksViewModel: SingerTracksViewModelInterface {
   /// MARK - Data Source
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())?
    
    /// MARK: - View Model properties
    private lazy var listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]

    /// MARK: - Use Cases
    private var singerTracksWorker: SingerTracksWorkerUseCaseInterface!
    
    init(useCase: SingerTracksWorkerUseCaseInterface) {
        singerTracksWorker = useCase
        
        useCase.subscribeOfData { [weak self] data in
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
}
