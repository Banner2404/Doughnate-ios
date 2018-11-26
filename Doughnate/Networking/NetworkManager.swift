//
//  NetworkManager.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/26/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func perform<T: Decodable>(_ request: URLRequest, responseType: T.Type, completion: @escaping ResponseCompletion<T, NetworkError>) {
        print(request.httpMethod ?? "", request.url?.absoluteString ?? "")
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.client(error)))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                    let data = data else {
                        completion(.failure(.incorrectResponse))
                        return
                }
                print("Response", try? JSONSerialization.jsonObject(with: data, options: []))
                guard httpResponse.statusCode < 400 else {
                    completion(.failure(.statusCode(httpResponse.statusCode)))
                    return
                }
                guard let responseObject = try? JSONDecoder().decode(responseType, from: data) else {
                    completion(.failure(.unableToParse(data)))
                    return
                }
                completion(.success(responseObject))
            }
            }.resume()
    }
}
