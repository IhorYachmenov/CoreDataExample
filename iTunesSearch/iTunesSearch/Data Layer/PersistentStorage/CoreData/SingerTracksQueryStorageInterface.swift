//
//  SingerTrackQueryStorageInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol SingerTracksQueryStorageInterface {
    func fetchSingerTracks(completion: @escaping (Result<[DataModel.SingerTrack], StorageError>) -> ())
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
    
    /// **NSFetchResultController API
    var publisherOfData: (([DataModel.SingerTrack]) -> ())? { get set }
}
