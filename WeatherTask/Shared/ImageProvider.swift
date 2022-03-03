//
//  ImageProvider.swift
//  WeatherTask
//
//  Created by usama on 03/03/2022.
//

import Foundation
import Kingfisher

final class ImageProvider {
    typealias ImageHandler = (UIImage?, Error?) -> Void
    
     static func getImage(urlString: String?, completion: @escaping ImageHandler) {
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        let cache = ImageCache.default
        let resource = ImageResource(downloadURL: url)
        
        if cache.isCached(forKey: urlString) {
            
            cache.retrieveImage(forKey: "cacheKey") { result in
                switch result {
                case .success(let value):
                    switch value {
                    case .none:
                        self.fetchImage(resource: resource, completion: completion)
                    case .disk:
                        DispatchQueue.main.async { completion(value.image, nil) }
                    case .memory:
                        DispatchQueue.main.async { completion(value.image, nil) }
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        } else {
            self.fetchImage(resource: resource, completion: completion)
        }
    }
    
    static func fetchImage(resource: ImageResource, completion: @escaping ImageHandler) {
        
        KingfisherManager.shared.retrieveImage(with: resource, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion(value.image, nil)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
