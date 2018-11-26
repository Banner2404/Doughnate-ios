//
//  Token.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "token"
    }
}
