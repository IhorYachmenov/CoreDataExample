//
//  QueryWorkerStorageInterfaceGeneric.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation
import CoreData

protocol QueryWorkerStorageInterfaceGeneric {
    associatedtype DataType
    associatedtype Entity: NSFetchRequestResult
    var dataPublisher: (([Entity]) -> ())? { get set }
    func saveSingerTrack(singerTrack: DataType, completion: @escaping (Result<DataType, StorageError>) -> ())
}
