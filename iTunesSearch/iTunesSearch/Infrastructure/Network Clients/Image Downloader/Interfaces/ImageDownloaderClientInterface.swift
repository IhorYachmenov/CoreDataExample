//
//  ImageDownloaderClientInterface.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation

protocol ImageDownloaderClientInterface {
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ())
}
