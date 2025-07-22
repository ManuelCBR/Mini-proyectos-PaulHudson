//
//  Order.swift
//  RetoCupcakeCorner
//
//  Created by Manuel Bermudo on 16/7/25.
//

import Foundation

//Reto 1
extension String {
    var isValidField: Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedString.isEmpty
    }
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAdress = "streetAdress"
        case _city = "city"
        case _zip = "zip"
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAdress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAdress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        //Reto 1
        if !name.isValidField || !streetAdress.isValidField || !city.isValidField || !zip.isValidField {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        // Complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity) * 2
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    //Reto 3
    func saveUserOrder (){
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(streetAdress, forKey: "streetAddress")
        UserDefaults.standard.set(city, forKey: "city")
        UserDefaults.standard.set(zip, forKey: "zip")
    }
    func loadUserOrder (){
        name = UserDefaults.standard.string(forKey: "name") ?? ""
        streetAdress = UserDefaults.standard.string(forKey: "streetAddress") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        zip = UserDefaults.standard.string(forKey: "zip") ?? ""
    }
}

