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
                
                guard let latestNews = try? JSONDecoder().decode(LatestNews.self, from: data) else {
                    completion(.failure(.decodeFailed))
                    return
                }
                
                completion(.success(latestNews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getDate(tab: String, date: Date, completion: @escaping (Result<DateNews, Network.Failure>) -> Void) {
        let requestDate = date.addingTimeInterval(24 * 60 * 60)
        Network.fetch("https://news-at.zhihu.com/api/4/news/before/\(requestDate.format(with: "yyyyMMdd"))") { result in
            switch result {
            case .success(let (data, response)):
                guard response.statusCode == 200 else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let dateNews = try? JSONDecoder().decode(DateNews.self, from: data) else {
                    completion(.failure(.decodeFailed))
                    return
                }
                
                for story in dateNews.stories {
                    story.tab = tab
                    story.date = date
                }
                
                completion(.success(dateNews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension Date {
    func format(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func createDate(from format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self) ?? Date()
    }
}
