//
//  SingerTrackDetailsViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

protocol SingerTrackDetailsViewModelInterface {
    func fetchTrackDetailsWith(id: Int, completion: @escaping (Result<PresentationModel.SingerTrackDetail, StorageError>) -> ())
}
