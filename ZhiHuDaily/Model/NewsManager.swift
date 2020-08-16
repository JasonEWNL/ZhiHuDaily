//
//  NewsManager.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/9/20.
//

import Foundation

struct NewsManager {
    static func getLatest(completion: @escaping (Result<LatestNews, Network.Failure>) -> Void) {
        Network.fetch("https://news-at.zhihu.com/api/4/news/latest") { result in
            switch result {
            case .success(let (data, response)):
                guard response.statusCode == 200 else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let news = try? JSONDecoder().decode(LatestNews.self, from: data) else {
                    completion(.failure(.decodeFailed))
                    return
                }
                
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
