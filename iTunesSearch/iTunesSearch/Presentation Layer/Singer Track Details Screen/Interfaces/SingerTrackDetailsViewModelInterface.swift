//
//  SingerTrackDetailsViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

protocol SingerTrackDetailsViewModelInterface {
    var imageSource: ((Result<Data, Error>) -> ())? { get set }
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ())
}
