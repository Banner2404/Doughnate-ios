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
    
    func forgotPassword(email: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.forgotPassword(email: email)
        networkManager.perform(request, completion: completion)
    }
    
    func changePassword(old: String, new: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.changePassword(old: old, new: new)
        networkManager.perform(request, completion: completion)
    }
    
    func update(firstName: String, lastName: String, userId: Int, token: String, completion: @escaping ResponseCompletion<User, NetworkError>) {
        let request = Requests.update(userId: userId, firstName: firstName, lastName: lastName, token: token)
        networkManager.perform(request, responseType: User.self, completion: completion)
    }
    
    func getProjects(completion: @escaping ResponseCompletion<[Project], NetworkError>) {
        let request = Requests.getProjects()
        networkManager.perform(request, responseType: [Project].self, completion: completion)
    }
    
    func report(projectId: Int, message: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.report(projectId: projectId, message: message)
        networkManager.perform(request, completion: completion)
    }
    
    func subscribe(projectId: Int, subscriptionId: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.subscribe(projectId: projectId, subscriptionId: subscriptionId, token: token)
        networkManager.perform(request, completion: completion)
    }
}
