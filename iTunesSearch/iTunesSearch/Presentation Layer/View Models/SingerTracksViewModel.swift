//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

class SingerTracksViewModel {
    
    init() {}
    
    private(set) var data: Array<SingerTrackViewEntity> = Array()
    
    var networkDataSource: ((NetworkRequestsState, Result<String, ServiceError>?) ->())?
    var storageDataSource: ((StorageError?) ->())?
    
    private lazy var searchSingerTracksUseCase: SearchSingerTracksUseCaseInterface = SearchSingerTracksUseCase()
    private lazy var storageSingerTracksUseCase: StorageSingerTracksUseCaseInterface = StorageSingerTracksUseCase()
    
    private let listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]
    
    func findRandomArtistTracks() {
        networkDataSource?(.InProgress, nil)
        
        searchSingerTracksUseCase.searchSingerTracks(singerName: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(let success):
                print(success.count)
                
                self?.networkDataSource?(.Completed, .success("Singers tracks loaded 🤩"))
                
                self?.saveSingersTrackToStorage(success)
                
            case .failure(let failure):
                self?.networkDataSource?(.Completed, .failure(failure))
            }
        }
    }
    
    private func saveSingersTrackToStorage(_ entities: [SingerTrackViewEntity]) {
        storageSingerTracksUseCase.saveSingerTracks(singerTracks: entities, completition: { [weak self] result in
            switch result {
            case .success(let success):
                self?.storageDataSource?(nil)
            case .failure(let failure):
                self?.storageDataSource?(failure)
            }
        })
    }
    
    
    
}
