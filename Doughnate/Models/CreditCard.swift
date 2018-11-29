//
//  CreditCard.swift
//  Doughnate
//
//  Created by Евгений Соболь on 11/29/18.
//  Copyright © 2018 Евгений Соболь. All rights reserved.
//

import UIKit

struct CreditCard {
    
    let lastFour: String
    let brand: Brand
    
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
    }
    
}
