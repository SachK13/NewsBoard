//
//  NewsViewModel.swift
//  NewsBoard
//
//  Created by Sachin on 25/09/22.
//

import Foundation

struct NewsViewModel {
    let news: News
    
    var author: String {
        return news.author ?? "Not Available"
    }
    
    var title: String {
        return news.title ?? "Not Available"
    }
    
    var description: String {
        return news.description ?? "Not Available"
    }
    
    var url: String {
        return news.url?.getATSPolicySupportedURLString() ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage?.getATSPolicySupportedURLString() ?? "https://www.kindpng.com/picc/m/182-1827064_breaking-news-banner-png-transparent-background-breaking-news.png"
    }
}

extension String {
    func getATSPolicySupportedURLString() -> String? {
        guard var comps = URLComponents(string: self) else  {
            return ""
        }
        comps.scheme = "https"
        let httpsUrlString = comps.string
        return httpsUrlString
    }
}
