//
//  SubscribeToDataUpdateUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 01.02.2023.
//

import Foundation

/// **NSFetchResultController API
protocol SubscribeToDataUpdateUseCaseInterface {
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ())
}
