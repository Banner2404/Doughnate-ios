//
//  User.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let isTwoFactorAuthenticationEnabled: Bool
    let creditCards: [CreditCard]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.email = "123@test.com"
        self.isTwoFactorAuthenticationEnabled = true
        self.creditCards = []
    }
    
    init(firstName: String, lastName: String, email: String, creditCards: [CreditCard]) {
        self.id = 6
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.isTwoFactorAuthenticationEnabled = true
        self.creditCards = creditCards
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
