//
//  Account.swift
//  Doughnate
//
//  Created by Евгений Соболь on 12/2/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct Account: Decodable {
    
    let user: User
    let token: Token
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.user = try container.decode(User.self, forKey: .user)
        let token = try container.decode(String.self, forKey: .token)
        self.token = Token(accessToken: token)
    }
    
    enum CodingKeys: String, CodingKey {
        case user
        case token
    }
}
