//
//  NetworkManager.swift
//  NewsBoard
//
//  Created by Sachin on 25/09/22.
//

import Foundation

class NetworkManager {
    let imageCache = NSCache<NSString, NSData>()
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let topHeadLinesUS = "top-headlines?country=us"
    
    
    // MARK: - News
    func getNews(completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseUrlString)\(topHeadLinesUS)&apiKey=\(APIKey.key)"
        
        guard let newsUrl = URL(string: urlString) else {
            // Log Error
            print("Failed to create NewsURL")
            return
        }
        
        let urlRequest = URLRequest(url: newsUrl)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil, let responseData = data else {
                print("Failed to get News Response")
                completion(nil)
                return
            }
            
            // Json Parsing For News
            guard let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: responseData) else {
                completion(nil)
                return
            }
            completion(newsEnvelope.articles)
        }
        .resume()
    }
    
    // MARK: - News Image
    func getImage(for imageUrl: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        /// Check if image data is present in image cache or not
        /// if it does get & pass it to completion handler
        /// if not download image data from image url & save it to image cache
        /// & pass it to completion handler
        if let cacheImage = imageCache.object(forKey: NSString(string: imageUrl)) {
            completion(cacheImage as Data)
        } else {
            let urlRequest = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                guard error == nil, let imageData = data else {
                    print("Failed to get Image Response")
                    completion(nil)
                    return
                }
                
                self.imageCache.setObject(imageData as NSData, forKey: NSString(string: imageUrl))
                completion(imageData)
            }
            .resume()
        }
    }
}
 
