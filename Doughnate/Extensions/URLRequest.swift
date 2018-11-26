//
//  URLRequest.swift
//  TestTask
//
//  Created by Евгений Соболь on 11/16/18.
//  Copyright © 2018 Eugene Sobol. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init?(method: HTTPMethod, domain: String, path: [String] = [], query: [(key: String, value: String?)] = [], body: [String: Any]? = nil, headers: [(key: String, value: String)] = []) {
        guard var url = URL(string: domain) else { return nil }
        path.forEach { url.appendPathComponent($0) }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = query.filter { $1 != nil }.map { URLQueryItem(name: $0, value: $1) }
        guard let resultUrl = components.url else { return nil }
        self.init(url: resultUrl)
        self.httpMethod = method.rawValue
        if let body = body {
            self.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [.prettyPrinted])
            self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        headers.forEach { self.addValue($1, forHTTPHeaderField: $0) }
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
