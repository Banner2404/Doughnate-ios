//
//  ActiveSubscription.swift
//  Doughnate
//
//  Created by Евгений Соболь on 12/18/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct ActiveSubscription: Decodable {

    let plan: SubscriptionType
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case plan
        case userId = "user_id"
    }
}
