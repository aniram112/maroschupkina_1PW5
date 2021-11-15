//
//  ArticlePage.swift
//  maroschupkina_1PW5
//
//  Created by Marina Roshchupkina on 14.11.2021.
//

import UIKit
struct ArticlePage: Decodable {
    var news: [ArticleModel]?
    var requestId: String?
    
    mutating func passTheRequestId() {
        for i in 0..<(news?.count ?? 0) {
            news?[i].requestId = requestId
        }
    }
}
