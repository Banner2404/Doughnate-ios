//
//  UserManager.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

class UserManager {
    
    static let shared = UserManager(keychainManager: .shared)
    private(set) var token: Token?
    var isAuthenticated: Bool {
        return token != nil
    }
    
    private let keychainManager: KeychainManager
    
    private init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    func authenticate(with token: Token) {
        self.token = token
        keychainManager.save(token)
    }
    
    func unauthenticate() {
        self.token = nil
        keychainManager.deleteToken()
    }
    
    func restoreCredentials() {
        self.token = keychainManager.loadToken()
    }
}
