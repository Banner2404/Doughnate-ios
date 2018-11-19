//
//  UserManager.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    var isAuthenticated = false
    
    private init() {}
}
