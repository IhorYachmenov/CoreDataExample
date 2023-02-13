//
//  QueryWorkerStorageInterfaceGeneric.swift
//  iTunesSearch
//
//  Created by user on 03.02.2023.
//

import Foundation
import CoreData

protocol QueryWorkerStoragable {
    associatedtype DataType
    associatedtype Entity: NSManagedObject
    var dataPublisher: (([Entity]) -> ())? { get set }
    func saveDataModel(data: DataType, completion: @escaping (Result<DataType, StorageError>) -> ())
    func fetchDataModelWith(id: String, completion: @escaping (Result<Entity, StorageError>) -> ())
}
