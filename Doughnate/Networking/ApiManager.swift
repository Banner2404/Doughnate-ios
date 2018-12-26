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
    
    func login(email: String, password: String, completion: @escaping ResponseCompletion<Account, NetworkError>) {
        let request = Requests.login(email: email, password: password)
        networkManager.perform(request, responseType: Account.self) { response in
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
    
    func loginSMS(code: String, completion: @escaping ResponseCompletion<Account, NetworkError>) {
        let request = Requests.loginSMS(code: code)
        networkManager.perform(request, responseType: Account.self, completion: completion)
    }
    
    func signup(email: String, password: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.signup(email: email, password: password)
        networkManager.perform(request, completion: completion)
    }
    
    func forgotPassword(email: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.forgotPassword(email: email)
        networkManager.perform(request, completion: completion)
    }
    
    func changePassword(old: String, new: String, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.changePassword(old: old, new: new, token: token)
        networkManager.perform(request, completion: completion)
    }
    
    func update(firstName: String, lastName: String, userId: Int, token: String, completion: @escaping ResponseCompletion<User, NetworkError>) {
        let request = Requests.update(userId: userId, firstName: firstName, lastName: lastName, token: token)
        networkManager.perform(request, responseType: User.self, completion: completion)
    }
    
    func getProjects(token: String?, completion: @escaping ResponseCompletion<[Project], NetworkError>) {
        let request = Requests.getProjects(token: token)
        networkManager.perform(request, responseType: [Project].self, completion: completion)
    }

    func getProject(id: Int, token: String?, completion: @escaping ResponseCompletion<Project, NetworkError>) {
        let request = Requests.getProject(id: id, token: token)
        networkManager.perform(request, responseType: Project.self, completion: completion)
    }
    
    func report(projectId: Int, message: String, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.report(projectId: projectId, message: message, token: token)
        networkManager.perform(request, completion: completion)
    }
    
    func subscribe(projectId: Int, subscriptionId: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.subscribe(projectId: projectId, subscriptionId: subscriptionId, token: token)
        networkManager.perform(request, completion: completion)
    }

    func unsubscribe(projectId: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.unsubscribe(projectId: projectId, token: token)
        networkManager.perform(request, completion: completion)
    }
    
    func enableTwoFactorAuth(phone: String, userId: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.enableTwoFactorAuth(userId: userId, phone: phone, token: token)
        networkManager.perform(request, completion: completion)
    }

    func update(phone: String, userId: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.update(phone: phone, userId: userId, token: token)
        networkManager.perform(request, completion: completion)
    }
    
    func disableTwoFactorAuth(userId: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.disableTwoFactorAuth(userId: userId, token: token)
        networkManager.perform(request, completion: completion)
    }

    func confirmTwoFactor(code: String, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.confirmTwoFactor(code: code, token: token)
        networkManager.perform(request, completion: completion)
    }

    func getCards(token: String, completion: @escaping ResponseCompletion<[CreditCard], NetworkError>) {
        let request = Requests.getCards(token: token)
        networkManager.perform(request, responseType: [CreditCard].self, completion: completion)
    }

    func addCard(stripeToken: String, token: String, completion: @escaping ResponseCompletion<CreditCard, NetworkError>) {
        let request = Requests.addCard(stripeToken: stripeToken, token: token)
        networkManager.perform(request, responseType: CreditCard.self, completion: completion)
    }

    func deleteCard(id: Int, token: String, completion: @escaping SimpleResponseCompletion<NetworkError>) {
        let request = Requests.deleteCard(id: id, token: token)
        networkManager.perform(request, completion: completion)
    }

    func getSubscriptions(token: String, completion: @escaping ResponseCompletion<ProjectWrapper, NetworkError>) {
        let request = Requests.getSubscriptions(token: token)
        networkManager.perform(request, responseType: ProjectWrapper.self, completion: completion)
    }
}
