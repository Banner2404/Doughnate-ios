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
        networkManager.perform(request, responseType: Token.self, completion: completion)
    }
    
}
