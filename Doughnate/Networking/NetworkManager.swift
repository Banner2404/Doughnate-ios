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
        perform(dataRequest: request) { response in
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let object = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(object))
                } else {
                    completion(.failure(.unableToParse(data)))
                }
            }
        }
    }
    
    func perform(_ request: URLRequest, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        perform(dataRequest: request) { response in
            switch response {
            case .failure(let error):
                completion(.failure(error))
            case .success(_):
                completion(.success)
            }
        }
    }
    
    private func perform(dataRequest request: URLRequest, completion: @escaping ResponseCompletion<Data, NetworkError>) {
        print(request.httpMethod ?? "", request.url?.absoluteString ?? "")
        if let body = request.httpBody, let json = try? JSONSerialization.jsonObject(with: body, options: []) {
            print("Body", json)
        }
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
                completion(.success(data))
            }
        }.resume()
    }
}
