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
    
    func loadToken() -> Token? {
        guard let accessToken = wrapper.string(forKey: Keys.accessToken) else { return nil }
        return Token(accessToken: accessToken)
    }
    
    func deleteToken() {
        wrapper.removeObject(forKey: Keys.accessToken)
    }
    
    struct Keys {
        static let accessToken = "AccessToken"
    }
}
