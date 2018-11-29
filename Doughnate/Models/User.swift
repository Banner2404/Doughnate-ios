//
//  User.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/19/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let isTwoFactorAuthenticationEnabled: Bool
    let creditCards: [CreditCard]
    
    init(firstName: String, lastName: String, email: String, creditCards: [CreditCard]) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.isTwoFactorAuthenticationEnabled = true
        self.creditCards = creditCards
    }
}
