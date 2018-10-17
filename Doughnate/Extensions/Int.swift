//
//  Int.swift
//  Doughnate
//
//  Created by Евгений Соболь on 10/17/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import Foundation

extension Int {
    
    var shortString: String {
        switch self {
        case ..<1000:
            return String(self)
        case 1000..<1_000_000:
            let value = Double(self) / 1000.0
            return NumberFormatter.oneFractionDigit.string(from: value as NSNumber)! + " k"
        case 1_000_000...:
            let value = Double(self) / 1_000_000.0
            return NumberFormatter.oneFractionDigit.string(from: value as NSNumber)! + " m"
        default:
            return ""
        }
    }
}
