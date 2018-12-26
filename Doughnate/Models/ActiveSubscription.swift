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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        plan = try container.decode(SubscriptionType.self, forKey: .plan)
        let profile = try container.nestedContainer(keyedBy: ProfileCodingKeys.self, forKey: .profile)
        userId = try profile.decode(Int.self, forKey: .id)
    }

    enum CodingKeys: String, CodingKey {
        case plan
        case profile
    }

    enum ProfileCodingKeys: String, CodingKey {
        case id
    }
}
