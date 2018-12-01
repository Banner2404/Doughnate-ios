//
//  Project.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct Project: Decodable {
    let imageUrl: String
    let name: String
    let description: String
    let subscribers: Int
    let category: Category
    let subscriptions: [SubscriptionType]
    
    var subscribersString: String {
        return subscribers.shortString + " subscribers"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = "https://i2.wp.com/beebom.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg?w=640&ssl=1"
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.subscribers = 100
        self.category = .youtube
        self.subscriptions = [SubscriptionType.init(interval: .month, amount: 10, description: "test description"),
                              SubscriptionType.init(interval: .week, amount: 40, description: "test description"),
                              SubscriptionType.init(interval: .day, amount: 2, description: "test description 123"),
                              SubscriptionType.init(interval: .year, amount: 1, description: "hello world")]
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
    }
}
