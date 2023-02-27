//
//  ImageDownloaderClient.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import Foundation

fileprivate let imageCache = NSCache<NSString, NSData>()

public final class ImageDownloaderClient: ImageDownloaderClientInterface {
    public init() {}
    
    public func downloadImage(url: String?, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let urlString = url else {
            completion(.failure(NSError.error(msg: Constants.Error.ImageClient.urlEmpty)))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError.error(msg: Constants.Error.ImageClient.notValidUrl)))
            return
        }
        
        
        if let data = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(.success(data as Data))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(NSError.error(msg: Constants.Error.ImageClient.downloadingError)))
                return
            }
            
            if let data = data {
                imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else {
                completion(.failure(NSError.error(msg: Constants.Error.ImageClient.dataCorrupted)))
            }
        }.resume()
    }
}

