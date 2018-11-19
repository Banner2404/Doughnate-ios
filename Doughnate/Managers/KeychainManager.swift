//
//  KeychainManager.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class KeychainManager {
    
    static let shared = KeychainManager()
    
    private let wrapper = KeychainWrapper.standard
    private init() {}
    
    func save(_ token: Token) {
        wrapper.set(token.accessToken, forKey: Keys.accessToken)
    }
    
    func save(_ user: User) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        wrapper.set(data, forKey: Keys.user)
    }
    
    func loadToken() -> Token? {
        guard let accessToken = wrapper.string(forKey: Keys.accessToken) else { return nil }
        return Token(accessToken: accessToken)
    }
    
    func loadUser() -> User? {
        guard let data = wrapper.data(forKey: Keys.user) else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    func deleteToken() {
        wrapper.removeObject(forKey: Keys.accessToken)
    }
    
    func deleteUser() {
        wrapper.removeObject(forKey: Keys.user)
    }
    
    struct Keys {
        static let accessToken = "AccessToken"
        static let user = "User"
    }
}
