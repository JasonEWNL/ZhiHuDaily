//
//  Network.swift
//  ZhiHuDaily
//
//  Created by JasonEWNL on 8/8/20.
//

import SwiftUI

struct Network {
    enum Failure: Error {
        case urlError, requestFailed, decodeFailed, unknownError
    }

    enum Method: String {
        case get = "GET"
        case post = "POST"
    }

    static func fetch(
        _ urlString: String,
        query: [String: String] = [:],
        headers: [String: String] = [:],
        method: Method = .get,
        body: [String: String] = [:],
        async: Bool = true,
        completion: @escaping (Result<(Data, HTTPURLResponse), Failure>) -> Void
    ) {
        // URL
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        // Query
        var requestURL: URL
        if query.isEmpty {
            requestURL = url
        } else {
            var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            comps.queryItems = comps.queryItems ?? []
            comps.queryItems!.append(contentsOf: query.map { URLQueryItem(name: $0.0, value: $0.1) })
            requestURL = comps.url!
        }
        
        // Headers
        var request = URLRequest(url: requestURL)
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Method
        request.httpMethod = method.rawValue
        
        // Body
        request.httpBody = body.percentEncoded()
        
        // Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            func process() {
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    print(error?.localizedDescription ?? "Unknown Error")
                    completion(.failure(.requestFailed))
                    return
                }
                completion(.success((data, response)))
                
                // Save Cookies
                guard let url = response.url, let headers = response.allHeaderFields as? [String: String] else {
                    completion(.failure(.requestFailed))
                    return
                }
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
                HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                for cookie in cookies {
                    var cookieProperties = [HTTPCookiePropertyKey: Any]()
                    cookieProperties[.name] = cookie.name
                    cookieProperties[.value] = cookie.value
                    cookieProperties[.domain] = cookie.domain
                    cookieProperties[.path] = cookie.path
                    cookieProperties[.version] = cookie.version
                    cookieProperties[.expires] = Date().addingTimeInterval(31536000)
                    
                    if let newCookie = HTTPCookie(properties: cookieProperties) {
                        HTTPCookieStorage.shared.setCookie(newCookie)
                    }
                }
            }
            
            if async {
                DispatchQueue.main.async {
                    process()
                }
            } else {
                process()
            }
        }.resume()
    }
    
    static func batch(
        _ urlString: String,
        query: [String: String] = [:],
        headers: [String: String] = [:],
        method: Method = .get,
        body: [String: String] = [:],
        completion: @escaping (Result<(Data, HTTPURLResponse), Failure>) -> Void
    ) {
        fetch(urlString, query: query, headers: headers, method: method, body: body, async: false, completion: completion)
    }
    
    static func batchImage(_ urlString: String, completion: @escaping (Result<Image, Failure>) -> Void) {
        batch(urlString) { result in
            switch result {
            case .success(let (data, response)):
                guard response.statusCode == 200 else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let uiImage = UIImage(data: data) else {
                    completion(.failure(.decodeFailed))
                    return
                }
                
                completion(.success(Image(uiImage: uiImage)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
