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
    
    
    func getNews(completion: @escaping ([News]?) -> Void) {
        let urlString = "\(baseUrlString)\(topHeadLinesUS)&apiKey=\(APIKey.key)"
        
        guard let newsUrl = URL(string: urlString) else {
            // Log Error
            print("Failed to create NewsURL")
            return
        }
        
        let urlRequest = URLRequest(url: newsUrl)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard error == nil, let responseData = data else {
                print("Failed to get News Response")
                completion(nil)
                return
            }
            
            // Json Parsing For News
            let newsEnvelope = try? JSONDecoder().decode(NewsEnvelope.self, from: responseData)
            newsEnvelope == nil ? completion(nil) : completion(newsEnvelope!.articles)
            
        }.resume()
    }
}
