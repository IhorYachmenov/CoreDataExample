//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

enum ViewModelDataSourceType {
    case NetworkDataSource
    case PersistentStorageDataSource
}

class SingerTracksViewModel {
    
    init() {}
    
    var data: Array<SingerTrackViewEntity> = Array()
    var viewModelDataSource: ((ViewModelDataSourceType, NetworkRequestsState, Result<String, ServiceError>?) -> ())?
    
    private lazy var searchSingerTracksUseCase = SearchSingerTracksUseCase()
    
    private let listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]
    
    func findRandomArtistTracks() {
        viewModelDataSource?(.NetworkDataSource, .InProgress, nil)
        searchSingerTracksUseCase.searchSingerTracks(singerName: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(let success):
                print(success.count)
                self?.viewModelDataSource?(.NetworkDataSource, .Completed, .success("Singers tracks loaded 🤩"))

            case .failure(let failure):
                self?.viewModelDataSource?(.NetworkDataSource, .Completed, .failure(failure))
            }
        }
    }
    
    
    
}
