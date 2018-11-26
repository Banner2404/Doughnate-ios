//
//  ApiManager.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/26/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    private let networkManager = NetworkManager.shared
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping ResponseCompletion<Token, NetworkError>) {
        let request = Requests.login(email: email, password: password)
        networkManager.perform(request, responseType: Token.self) { response in
            switch response {
            case .failure(let error):
                switch error {
                case .unableToParse(let data) where ((try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any])?["message"] != nil:
                    completion(.failure(.smsVerificationRequired))
                default:
                    completion(.failure(error))
                }
            case .success(let token):
                completion(.success(token))
            }
        }
    }
    
    func loginSMS(code: String, completion: @escaping ResponseCompletion<Token, NetworkError>) {
        let request = Requests.loginSMS(code: code)
        networkManager.perform(request, responseType: Token.self, completion: completion)
    }
    
    func signup(email: String, password: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.signup(email: email, password: password)
        networkManager.perform(request, completion: completion)
    }
    
}
