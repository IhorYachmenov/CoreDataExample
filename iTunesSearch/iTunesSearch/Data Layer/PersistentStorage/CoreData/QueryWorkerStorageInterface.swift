//
//  SingerTrackQueryStorageInterface.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation

protocol QueryWorkerStorageInterface {
    var dataPublisher: (([DataModel.SingerTrack]) -> ())? { get set }
    func saveSingerTrack(singerTrack: DataModel.SingerTrack, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
}
