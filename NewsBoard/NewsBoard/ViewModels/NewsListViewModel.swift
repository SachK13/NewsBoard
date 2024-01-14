//
//  NewsListViewModel.swift
//  NewsBoard
//
//  Created by Sachin on 25/09/22.
//

import Foundation

class NewsListViewModel {
    var newsVM: [NewsViewModel] = []
    let reuseID = "NewsCell"
    
    func getNews(completion: @escaping ([NewsViewModel]) -> Void) {
        NetworkManager.shared.getNews { news in
            guard let news = news else { return }
            let newsVM = news.map(NewsViewModel.init)
            
            DispatchQueue.main.async {
                self.newsVM = newsVM
                completion(self.newsVM)
            }
        }
    }
}
