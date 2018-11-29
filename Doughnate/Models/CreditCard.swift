//
//  CreditCard.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/29/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

struct CreditCard: Codable {
    
    let lastFour: String
    let brand: Brand
    
    init(lastFour: String, brand: Brand) {
        self.lastFour = lastFour
        self.brand = brand
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lastFour = try container.decode(String.self, forKey: .lastFour)
        let brand = try container.decode(String.self, forKey: .brand)
        self.brand = Brand(string: brand)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lastFour, forKey: .lastFour)
        try container.encode(brand.rawValue, forKey: .brand)
    }
    
    enum CodingKeys: String, CodingKey {
        case lastFour
        case brand
    }
    
    enum Brand {
        case visa
        case mastercard
        case generic(String)
        
        var image: UIImage {
            switch self {
            case .visa:
                return #imageLiteral(resourceName: "credit_card_visa.pdf")
            case .mastercard:
                return #imageLiteral(resourceName: "credit_card_mastercard.pdf")
            case .generic(_):
                return #imageLiteral(resourceName: "credit_card_generic.pdf")
            }
        }
        
        var title: String {
            switch self {
            case .visa:
                return "Visa"
            case .mastercard:
                return "MasterCard"
            case .generic(let brand):
                return brand
            }
        }
        
        var rawValue: String {
            switch self {
            case .visa:
                return "visa"
            case .mastercard:
                return "mastercard"
            case .generic(let brand):
                return brand
            }
        }
        
        init(string: String) {
            switch string.lowercased() {
            case "visa":
                self = .visa
            case "mastercard":
                self = .mastercard
            default:
                self = .generic(string)
            }
        }
    }

    
}
