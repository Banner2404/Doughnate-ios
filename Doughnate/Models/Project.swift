//
//  Project.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct Project: Decodable {
    let id: Int
    let imageUrl: String
    let name: String
    let description: String
    let subscribers: Int
    let category: Category
    let subscriptions: [SubscriptionType]
    var activeSubscription: SubscriptionType?
    
    var subscribersString: String {
        return subscribers.shortString + " subscribers"
    }
    
    var isSubscribed: Bool {
        return activeSubscription != nil
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrl = "https://i2.wp.com/beebom.com/wp-content/uploads/2016/01/Reverse-Image-Search-Engines-Apps-And-Its-Uses-2016.jpg?w=640&ssl=1"
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.subscribers = 100
        self.category = .youtube
        self.subscriptions = try container.decode([SubscriptionType].self, forKey: .subscriptions)
        self.activeSubscription = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case subscriptions = "subscription_plans"
    }
}
