//
//  SingerTracksViewModelInterface.swift
//  iTunesSearch
//
//  Created by user on 01.02.2023.
//

import Foundation

protocol SingerTracksViewModelInterface {
    func downloadSong()
    func fetchSongs()
    var dataSource: ((Result<[PresentationModel.SingerTrack], Error>) -> ())? { get set }
}
