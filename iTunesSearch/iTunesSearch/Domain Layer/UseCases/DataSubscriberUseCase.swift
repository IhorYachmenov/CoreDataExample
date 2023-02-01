//
//  SubscribeToDataUpdateUseCase.swift
//  iTunesSearch
//
//  Created by user on 01.02.2023.
//

import Foundation

final class DataSubscriberUseCase {
    
    private var repository: PersistentStorageRepositoryInterface
    
    init(_ repository: PersistentStorageRepositoryInterface) {
        self.repository = repository
    }
}

extension DataSubscriberUseCase: DataSubscriberUseCaseInterface {
    
    func subscribeOfData(completion: @escaping ([DataModel.SingerTrack]) -> ()) {
        repository.subscribeOfData(completion: completion)
    }
}
