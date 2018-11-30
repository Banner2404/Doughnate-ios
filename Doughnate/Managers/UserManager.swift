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
    private(set) var user: User?
    
    var isAuthenticated: Bool {
        return token != nil && user != nil
    }
    
    private let keychainManager: KeychainManager
    
    private init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    func authenticate(with user: User, token: Token) {
        self.token = token
        self.user = user
        keychainManager.save(token)
        keychainManager.save(user)
    }
    
    func unauthenticate() {
        self.token = nil
        self.user = nil
        keychainManager.deleteToken()
        keychainManager.deleteUser()
    }
    
    func restoreCredentials() {
        self.token = keychainManager.loadToken()
        self.user = keychainManager.loadUser()
    }
    
    func update(_ user: User) {
        self.user = user
        keychainManager.save(user)
    }
}
