//
//  SingerTrackDetailsUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 13.02.2023.
//

import Foundation

protocol SingerTrackDetailsUseCaseInterface {
    #warning("Q: - Result not a media model")
    #warning("Q: - Media layer architecture")
    func downloadImage(url: String?, completion: @escaping (Result<Data, Error>) -> ())
    func fetchTrackDetails(trackId: String, completion: @escaping (Result<DataModel.SingerTrack, StorageError>) -> ())
    
    // In progress
    func playTrack(url: String?)
    func subscribeOnAudioData(completion: @escaping (Result<MediaModel.PlayerObject, Error>) -> ())
}
