//
//  SingerTrackDataProviderInterface.swift
//  iTunesSearch
//
//  Created by user on 30.01.2023.
//

import Data_Layer
#warning("docC")
#warning("downloadAndSaveSingerTrack <- , naming observe etc.")
public protocol SingerTracksWorkerUseCaseInterface {
    func downloadAndSaveSingerTrack(name: String, completion: @escaping (Error?) -> ())
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ())
}
