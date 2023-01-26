//
//  TrackListViewModel.swift
//  iTunesSearch
//
//  Created by user on 24.01.2023.
//

import Foundation

class SingerTracksViewModel {
    
    init() {}
    // MARK: - View Model data
    private(set) var data: Array<SingerTrackViewEntity> = Array()
    private let fetchLimit = 15
    private let listOfSingers = ["Janet Jackson", "Eminem", "Katy Perry", "Lady Gaga", "Snoop Dogg", "Elvis Presley"]
    
    // MARK: - View Model API
    var networkDataSource: ((NetworkRequestsState, Result<String, ServiceError>?) ->())?
    var storageDataSource: ((StorageError?) ->())?

    // MARK: - Use Case
    private lazy var searchSingerTracksUseCase: SearchSingerTracksUseCaseInterface = SearchSingerTracksUseCase()
    private lazy var storageSingerTracksUseCase: StorageSingerTracksUseCaseInterface = StorageSingerTracksUseCase()
    
    
    
    func findRandomArtistTracks() {
        networkDataSource?(.inProgress, nil)
        
        searchSingerTracksUseCase.searchSingerTracks(singerName: listOfSingers.randomElement()!) { [weak self] result in
            switch result {
            case .success(let success):
            
                self?.networkDataSource?(.completed, .success("Singers tracks loaded 🤩"))
                
                self?.saveSingersTrackToStorage(success)
                
            case .failure(let failure):
                self?.networkDataSource?(.completed, .failure(failure))
            }
        }
    }
    
    func fetchSingerTracks() {
        storageSingerTracksUseCase.fetchSingerTracks(fetchLimit: fetchLimit) { [weak self] result in
            switch result {
            case .success(let success):
                self?.data += success
                self?.storageDataSource?(nil)
            case .failure(let failure):
                
                self?.storageDataSource?(.readError(failure))
            }
        }
    }
    
    private func saveSingersTrackToStorage(_ entities: [SingerTrackViewEntity]) {
        storageSingerTracksUseCase.saveSingerTracks(singerTracks: entities, completition: { [weak self] result in
            switch result {
            case .success(_):
                self?.storageDataSource?(nil)
            case .failure(let failure):
                self?.storageDataSource?(failure)
            }
        })
    }
    
}
