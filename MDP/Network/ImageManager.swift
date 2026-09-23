//
//  ImageManager.swift
//  MDP
//
//  Created by Laasya Priya vemuri on 9/16/26.
//

import Foundation
import UIKit

class ImageManager {
    
    // MARK: - Properties
    
    static let shared = ImageManager()
    
    nonisolated(unsafe) static let imageCache = NSCache<NSURL, UIImage>()
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - User Defined Methods
    
    func fetchImage(for url: URL, completion: @escaping @Sendable (Result<UIImage, Error>) -> Void) {
        if let cachedImage = ImageManager.imageCache.object(forKey: url as NSURL) {
            //print("Log:: Image fetched from cache")
            completion(.success(cachedImage))
            return
        }
        //print("Log:: The fetched image from server: \(url.absoluteString)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let imageData = data, let image = UIImage(data: imageData) else {
                return
            }
            
            //print("Log:: Image fetched from server")
            
            ImageManager.imageCache.setObject(image, forKey: url as NSURL)
            //print("Log:: The fetched image stored in cache: \(url.absoluteString)")
            completion(.success(image))
        }.resume()
    }
}
