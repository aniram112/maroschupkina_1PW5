//
//  ArticleModel.swift
//  maroschupkina_1PW5
//
//  Created by Marina Roshchupkina on 09.11.2021.
//

import UIKit

struct ArticleModel: Decodable {
    var newsId: Int?
    var title: String?
    var announce: String?
    var img: ImageContainer?
    var requestId: String?
    var articleUrl: URL? {
        let requestId = requestId ?? ""
        let newsId = newsId ?? 0
        return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
    }
    
    func loadImage() -> UIImage? {
        guard let data = try? Data(contentsOf: (img?.url)!) else {
            return nil
        }
        return UIImage(data: data)
    }
}

struct ImageContainer: Decodable {
    var url: URL?
}


