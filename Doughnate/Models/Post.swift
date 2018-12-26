//
//  Post.swift
//  Doughnate
//
//  Created by Евгений Соболь on 12/21/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct Post: Decodable {

    let text: String?
    let isPublic: Bool
    let dateString: String

    enum CodingKeys: String, CodingKey {
        case text
        case isPublic = "is_public"
        case dateString = "readable_created_at"
    }
}
