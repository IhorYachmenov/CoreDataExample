//
//  SingerTrackQueryStorage.swift
//  iTunesSearch
//
//  Created by user on 25.01.2023.
//

import Foundation
import CoreData

final class SingerTracksQueryStorage: NSObject, NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerWillChangeContent")
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        print("didChange atSectionIndex", type)
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("didChange for newIndexPath", newIndexPath ?? 9999)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("controllerDidChangeContent")
    }
    
    private let storage: SingerTrackStorage
    private var offsetNumber: Int = 0
    
    private lazy var fetchedResultsController: NSFetchedResultsController<SingerTrack> = {
        
        let context = storage.fetchManageObjectContext
        
        let request: NSFetchRequest<SingerTrack> = SingerTrack.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "singerName", ascending: true)
        ]
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
            print("NSFetchRC Success")
        } catch let err {
            print(err)
            print("NSFetchRC Failure", err)
        }
        
        return frc
    }()
    
    init(persistentStorage: SingerTrackStorage = SingerTrackStorage.shared) {
        storage = persistentStorage
    }
    
}

extension SingerTracksQueryStorage: SingerTracksQueryStorageInterface {
    
    func fetchSingerTracks(fetchLimit: Int, completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {

        do {

            let request: NSFetchRequest = SingerTrack.fetchRequest()

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
        
//        if (fetchedResultsController.fetchedObjects == nil) {
//            let error: Error = NSError(domain: "", code: 400, userInfo: [ NSLocalizedDescriptionKey : "Fetched objects nil"])
//            completition(.failure(.readError(error)))
//
//        } else {
//            let data = fetchedResultsController.fetchedObjects!.map({ $0.toData() })
//            completition(.success(data))
//        }
    }
    
    func saveSingerTracks(singerTracks: [SingerTrackEntity], completition: @escaping (Result<[SingerTrackEntity], StorageError>) -> ()) {
        
        guard !singerTracks.isEmpty else { return }
 
        singerTracks.forEach({ let _ = SingerTrack(query: $0, insertInto: storage.saveManageObjectContext) })
        
        storage.saveContext { error in
            guard error != nil else {
                completition(.success(singerTracks))
                return
            }
            completition(.failure(error!))
        }
    }
    
    
    
}


//extension SingerTracksQueryStorage: NSFetchedResultsControllerDelegate {
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        print("controllerWillChangeContent")
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        print("controllerDidChangeContent")
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        print("didChange for newIndexPath")
//    }
//    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//        print("didChange atSectionIndex for")
//    }
//
//}































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
