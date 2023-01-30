//
//  SingerTrackDataProvider.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Foundation

class SingerTrackDataProvider {
    
    private var search: SearchSingerTracksUseCaseInterface
    private var storage: StorageSingerTracksUseCaseInterface
    
    init(UseCase search:SearchSingerTracksUseCaseInterface, UseCase storage: StorageSingerTracksUseCaseInterface) {
        self.search = search
        self.storage = storage
    }
}

extension SingerTrackDataProvider: SingerTrackDataProviderInterface {
    func downloadSingerTrack(singerName: String, completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ()) {
        
        search.searchSingerTracks(singerName: singerName) { [weak self] result in
            switch result {
            case .success(let success):
                print(success.count)
                self?.storage.saveSingerTracks(singerTracks: success) { result in
                    completition(result)
                }
            case .failure(let failure):
                print(failure)
                self?.storage.fetchSingerTracks(fetchLimit: 15, completition: completition)
            }
        }
    }
    
    func fetchFromStorage(completition: @escaping (Result<[SingerTrackViewEntity], StorageError>) -> ()) {
        storage.fetchSingerTracks(fetchLimit: 15, completition: completition)
    }
    
}

