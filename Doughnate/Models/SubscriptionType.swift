//
//  SubscriptionType.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/30/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct SubscriptionType: Decodable {

    let id: Int
    let interval: Interval
    private let amount: Int
    let description: String
    var price: Double {
        return Double(amount) / 100.0
    }
    
    var title: String {
        let price = NumberFormatter.price.string(from: NSNumber(value: self.price)) ?? String(self.price)
        return "$\(price) per \(interval.rawValue)"
    }
    
    init() {
        self.id = 1
        self.interval = .day
        self.amount = 99
        self.description = "fdjgiodfmsogd"
    }
    
    enum Interval: String, Decodable {
        case day
        case week
        case month
        case year
    }
}
