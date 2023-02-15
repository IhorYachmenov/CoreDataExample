//
//  TrackDownloaderClientInterface.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation

protocol TrackDownloaderClientInterface {
    func downloadTrack(url: String?, completion: @escaping (Result<URL, Error>) -> ())
}
