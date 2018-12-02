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
    let name: String
    let description: String
    let subscribers: Int
    let category: Category
    let subscriptions: [SubscriptionType]
    var activeSubscription: SubscriptionType?
    
    private let imageUrlString: String

    var subscribersString: String {
        return subscribers.shortString + " subscribers"
    }
    
    var isSubscribed: Bool {
        return activeSubscription != nil
    }
    
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrlString = try container.decode(String.self, forKey: .imageUrlString)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.subscribers = 100
        self.category = .youtube
        self.subscriptions = try container.decode([SubscriptionType].self, forKey: .subscriptions)
        self.activeSubscription = nil
    }
    
    init() {
        self.id = 1
        self.name = "Mock"
        self.description = ""
        self.subscribers = 1
        self.category = .music
        self.subscriptions = []
        self.activeSubscription = nil
        self.imageUrlString = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case subscriptions = "subscription_plans"
        case imageUrlString = "logo_image"
    }
}
