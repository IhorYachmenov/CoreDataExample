//
//  AudioClientInterface.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation

protocol AudioClientInterface {
    associatedtype AudioObject
    var audioDataPublisher: ((Result<AudioObject, Error>) -> ())? { get set }
}