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
    func saveDataModel(data: DataType, completion: @escaping (StorageError?) -> ())
    func fetchEntity<T>(matching keyPath: KeyPath<Entity, T>, equalTo value: T, completion: @escaping (StorageError?) -> ())
}
