//
//  Project.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

struct Project {
    let name: String
    let description: String
    let subscribers: Int
    let category: Category
    
    var subscribersString: String {
        return subscribers.shortString + " subscribers"
    }
}
