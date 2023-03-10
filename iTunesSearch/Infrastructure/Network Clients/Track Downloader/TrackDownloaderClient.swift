//
//  TrackDownloaderClient.swift
//  iTunesSearch
//
//  Created by user on 15.02.2023.
//

import Foundation

public class TrackDownloaderClient {
    private var trackPathInFileSysytem: URL?
    
    public init() {}
    
    deinit {
        guard let url = trackPathInFileSysytem else { return }
        try? FileManager.default.removeItem(at: url)
    }
    
    private func fileUrl(name: String) -> URL? {
        let fileManager = FileManager.default
        let tempDirURL = fileManager.temporaryDirectory
        let filePath = tempDirURL.appendingPathComponent(name).path
        
        if fileManager.fileExists(atPath: filePath) {
            return URL(fileURLWithPath: filePath)
        } else {
            return nil
        }
    }
}

// MARK: - TrackDownloaderClientInterface
extension TrackDownloaderClient: TrackDownloaderClientInterface {
    public func downloadTrack(url: String?, completion: @escaping (Result<URL, Error>) -> ()) {
        guard let url = url else {
            completion(.failure(NSError.error(msg: Constants.Error.TrackDownloaderClient.urlEmpty)))
            return
        }
        guard let url = URL(string: url) else {
            completion(.failure(NSError.error(msg: Constants.Error.TrackDownloaderClient.notValidUrl)))
            return
        }
        
        let fileExtension = URL(fileURLWithPath: url.absoluteString).pathExtension
        let urlWithoutHttpSchema = url.lastPathComponent
        
        let fileName = "\(urlWithoutHttpSchema).\(fileExtension)"
        
        if let fileURL = fileUrl(name: fileName) {
            completion(.success(fileURL))
            return
        }
        
        let downloadTask = URLSession.shared.downloadTask(with: url) { [weak self] (location, response, error) in
            guard let location = location else {
                completion(.failure(NSError.error(msg: Constants.Error.TrackDownloaderClient.fileSystemUrlNotExist)))
                return
            }
            
            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            self?.trackPathInFileSysytem = fileURL

            do {
                try FileManager.default.moveItem(at: location, to: fileURL)
                completion(.success(fileURL))
            } catch {
                try? FileManager.default.removeItem(at: location)
                completion(.failure(error))
            }
        }
        downloadTask.resume()
    }
}
