//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

enum ViewModelActionState {
    case inProgress
    case completed
    case failure(Error)
}

class SingerTracksViewModel {
    
    /// MARK: - View Model data
    private(set) var data: Array<SingerTrackViewEntity> = Array()
    private lazy var listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]
    
    /// MARK: - Data Source
    var dataSource: ((ViewModelActionState) ->())?
    
    /// MARK: - Data Provider
    private var singerTrackDataProvider: SingerTrackDataProviderInterface
    
    // MARK: - Init
    init(_ dataProvider: SingerTrackDataProviderInterface) {
        singerTrackDataProvider = dataProvider
    }
    
    func downloadRandomSingerTrack() {
        dataSource?(.inProgress)
        
        singerTrackDataProvider.downloadSingerTrack(singerName: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(let success):
                self?.data += success
                self?.dataSource?(.completed)
            case .failure(let failure):
                self?.dataSource?(.failure(failure))
            }
        }
    }
    
    func fetchListOfSongsFromStorage() {
        singerTrackDataProvider.fetchFromStorage { [weak self] result in
            switch result {
            case .success(let success):
                self?.data = success
                self?.dataSource?(.completed)
            case .failure(let failure):
                self?.dataSource?(.failure(failure))
            }
        }
    }
    
}
