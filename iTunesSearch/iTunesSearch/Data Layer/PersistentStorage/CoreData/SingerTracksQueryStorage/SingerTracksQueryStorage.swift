//
//  SingerTrackQueryStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class SingerTracksQueryStorage {
    
    private let storage: SingerTrackStorage
    private var offsetNumber: Int = 0
    
    init(persistentStorage: SingerTrackStorage = SingerTrackStorage.shared) {
        storage = persistentStorage
    }
}

extension SingerTracksQueryStorage: SingerTracksQueryStorageInterface {
    
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {

        do {
            
            let request: NSFetchRequest = SingerTrackMO.fetchRequest()
            let count = try storage.fetchManageObjectContext.count(for: request)
            request.fetchLimit = fetchLimit
            
            let offset = (offsetNumber * fetchLimit)
            request.fetchOffset = offset
            
            let data = try storage.fetchManageObjectContext.fetch(request)
            
            if (offset < count) {
                self.offsetNumber += 1
            }
            print( "Fetch number", self.offsetNumber, "Offset number", offset, "DB count", count)
            completition(.success(data.toData()))
        } catch {
            
            if (self.offsetNumber != 0) {
                self.offsetNumber -= 1
            }
            
            completition(.failure(.readError(error)))
        }
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        
        guard !singerTracks.isEmpty else { return }
 
        storage.saveManageObjectContext.perform {
            
            singerTracks.forEach({ track in
                let _ = SingerTrackMO(query: track, insertInto: self.storage.saveManageObjectContext)
            })
            
            self.storage.saveContext { error in
                guard error != nil else {
                    completition(.success(singerTracks))
                    return
                }
                completition(.failure(error!))
            }
        }
        

    }
    
    
    
}


































// MARK: private

extension SingerTracksQueryStorage {
    
//    private func cleanUpQueries(for query: SingerTrackEntity, inContext context: NSManagedObjectContext) throws {
//        let request: NSFetchRequest = SingerTrackMO.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(SingerTrackMO.trackName),
//                                                    ascending: false)]
//        var result = try context.fetch(request)
//
//        removeDuplicates(for: query, in: &result, inContext: context)
//        removeQueries(limit: maxStorageLimit - 1, in: result, inContext: context)
//    }
//
//    private func removeDuplicates(for query: SingerTrackEntity, in queries: inout [SingerTrackMO], inContext context: NSManagedObjectContext) {
//        queries
//            .filter { $0.trackName == query.trackName }
//            .forEach { context.delete($0) }
//        queries.removeAll { $0.trackName == query.trackName }
//    }
//
//    private func removeQueries(limit: Int, in queries: [SingerTrackMO], inContext context: NSManagedObjectContext) {
//        guard queries.count > limit else { return }
//
//        queries.suffix(queries.count - limit)
//            .forEach { context.delete($0) }
//    }
    

}
