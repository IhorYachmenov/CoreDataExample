//
//  Mapper.swift
//  iTunesSearch
//
//  Created by user on 04.02.2023.
//

import Foundation
import CoreData

class Mapper {
    init(){}
    
    func mapToEntity<DataEntity, Entity>(from data: DataEntity, target dbEntity: Entity, completion: @escaping (Result<DataEntity, StorageError>)->()) {
        let managedObject: NSManagedObject? = dbEntity as? NSManagedObject
        let keys = managedObject?.entity.attributesByName.keys

        if (keys != nil) {
            let domainEntityMirror = Mirror(reflecting: data)
            for dbEntityKey in keys! {
                for property in domainEntityMirror.children.enumerated() where
                property.element.label == dbEntityKey {
                    let value = property.element.value as AnyObject
                    if !value.isKind(of: NSNull.self) {
                        managedObject?.setValue(value, forKey: dbEntityKey)
                    }
                }
            }
            completion(.success(data))
        } else {
            let failure = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Wrong mapping keys"])
            completion(.failure(.saveError(failure)))
        }
    }
}
