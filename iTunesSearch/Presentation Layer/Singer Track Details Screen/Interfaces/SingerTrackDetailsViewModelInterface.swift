//
//  SingerTrackDetailsViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//


import Foundation
import Data_Model_Layer

public protocol SingerTrackDetailsViewModelInterface {
    var observeData: ((Result<PresentationModel.SingerTrackDetails, Error>) -> ())? { get set }
    func playTrack()
}
