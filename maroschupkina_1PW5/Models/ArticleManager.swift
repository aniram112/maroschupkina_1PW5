//
//  ArticleManager.swift
//  maroschupkina_1PW5
//
//  Created by Marina Roshchupkina on 11.11.2021.
//

import UIKit
protocol ArticleManagerObserver {
    func updateArticles()
}
class ArticleManager {
    var newsPage: Int = 2
    var observer: ArticleManagerObserver?
    public var articles: [ArticleModel]? = []
    var articlePage: ArticlePage?
    public var Articles: [ArticleModel] = [] {
        didSet {
            observer?.updateArticles()
        }
    }
    
    
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    
    
    private func fetchNews(page: Int) {
        guard let url = getURL(4, page) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                var articlePage = try?
                    JSONDecoder().decode(ArticlePage.self, from: data)
                articlePage?.passTheRequestId()
                self?.Articles.append(contentsOf: (articlePage?.news)!)
            }
        }.resume()
    }
    
    public func loadNews(){
        fetchNews(page: 1);
    }
    public func loadMore(){
        fetchNews(page: newsPage);
        newsPage+=1
    }
}

