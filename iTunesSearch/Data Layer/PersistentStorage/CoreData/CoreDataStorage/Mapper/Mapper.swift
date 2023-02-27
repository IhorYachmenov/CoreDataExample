//
//  Mapper.swift
//  iTunesSearch
//
//  Created by user on 04.02.2023.
//

import Foundation
import CoreData

class Mapper {
    init() {}
    
    func mapToEntity<DataEntity, Entity: NSManagedObject>(from data: DataEntity, target dbEntity: Entity, completion: @escaping() -> ()) {
        let managedObject: NSManagedObject = dbEntity
        let keys = managedObject.entity.attributesByName.keys

        let domainEntityMirror = Mirror(reflecting: data)
        for dbEntityKey in keys {
            for property in domainEntityMirror.children.enumerated() where
            property.element.label == dbEntityKey {
                let value = property.element.value as AnyObject
                if !value.isKind(of: NSNull.self) {
                    managedObject.setValue(value, forKey: dbEntityKey)
                }
            }
        }
        completion()
    }
}
