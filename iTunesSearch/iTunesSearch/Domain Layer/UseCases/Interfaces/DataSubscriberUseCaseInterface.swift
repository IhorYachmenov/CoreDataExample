//
//  SubscribeToDataUpdateUseCaseInterface.swift
//  iTunesSearch
//
//  Created by user on 01.02.2023.
//

import Foundation

/// **NSFetchResultController API
protocol DataSubscriberUseCaseInterface {
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ())
}
