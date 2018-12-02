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
    let amount: Int
    let description: String
    
    var title: String {
        return "$\(amount) per \(interval.rawValue):"
    }
    
    enum Interval: String, Decodable {
        case day
        case week
        case month
        case year
    }
}
