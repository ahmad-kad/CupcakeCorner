//
//  Order.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/21/24.
//

import Foundation
@Observable
class Order: Codable {
    
    enum CodingKeys : String, CodingKey{
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = [
        "Vanilla",
        "Chocolate",
        "Red Velvet",
        "Strawberry",
        "Lemon",
        "Salted Caramel",
        "Cookies and Cream",
        "Pumpkin Spice",
        "Coconut",
        "Raspberry"
    ]
                            
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress : Bool{
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    var cost : Decimal {
        // Cake = 2 dollars
        var cost = Decimal(quantity) * 2
        
        
        cost += Decimal(type) / 2
        
        if extraFrosting{
            cost += Decimal(quantity)
        }
        if addSprinkles{
            cost += Decimal(quantity) / 2
        }
        
        return cost
        
    }

}
