//
//  SingerTrackDetailsViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

protocol SingerTrackDetailsViewModelInterface {
    var imageDataSource: ((Result<Data, Error>) -> ())? { get set }
    var audioDataSource: ((Result<PresentationModel.PlayerObject, Error>) -> ())? { get set }
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ())
    
    // In progress
    func playTrack(url: String?)
}
