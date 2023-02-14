//
//  ImageDownloaderClient.swift
//  iTunesSearch
//
//  Created by user on 14.02.2023.
//

import Foundation

fileprivate let imageCache = NSCache<NSString, NSData>()

class ImageDownloaderClient: NSObject {
    
    override init() {}
    
    func downloadImage(url: URL, completion: @escaping (Result<Data, Error>) -> ()) {
        if let data = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(.success(data as Data))
            }
            return
        }
        print("Data not in cache")
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil else {
                completion(.failure(NSError.error(msg: "Server error while donwloading image")))
                return
            }
            
            if let data = data {
                imageCache.setObject(data as NSData, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } else {
                completion(.failure(NSError.error(msg: "Download was successful but data corrupted")))
            }
        }.resume()
    }
}
