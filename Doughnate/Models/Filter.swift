//
//  Filter.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

enum Category {
    case youtube
    case twitter
    case music
    
    var string: String {
        return String(describing: self).capitalized
    }
    
    var color: UIColor {
        switch self {
        case .youtube:
            return .red
        case .twitter:
            return .blue
        case .music:
            return .green
        }
    }
}
