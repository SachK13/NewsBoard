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
}
