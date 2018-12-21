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
    let posts: [Post]
    var activeSubscriptions: [ActiveSubscription]

    private let imageUrlString: String

    var subscribersString: String {
        return subscribers.shortString + " subscribers"
    }
    
    var imageUrl: URL? {
        return URL(string: imageUrlString)
    }

    func activeSubscription(user: Int) -> SubscriptionType? {
        return activeSubscriptions.first { $0.userId == user }?.plan
    }

    func isSubscribed(user: Int) -> Bool {
        return activeSubscription(user: user) != nil
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
        self.activeSubscriptions = try container.decode([ActiveSubscription].self, forKey: .activeSubscriptions)
        self.posts = try container.decode([Post].self, forKey: .posts)
    }
    
    init() {
        self.id = 1
        self.name = "Project 1"
        self.description = ""
        self.subscribers = 1
        self.category = .music
        self.subscriptions = []
        self.activeSubscriptions = []
        self.posts = []
        self.imageUrlString = "https://scontent-frt3-2.xx.fbcdn.net/v/t1.0-9/581500_370263239723489_1400672702_n.jpg?_nc_cat=107&_nc_ht=scontent-frt3-2.xx&oh=4bd731c2b50c2bf782f18da8edc82817&oe=5C9E2D17"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case subscriptions = "subscription_plans"
        case imageUrlString = "logo_image"
        case activeSubscriptions = "subscriptions"
        case posts
    }
}
