//
//  BundleOffer.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 17/11/2020.
//

import Foundation

struct BundleOffer : Codable {
    var id : String?
    var name : String
    var items : [BundleItem]?
    var description : String
    var prepTime : String
    var subTotal : Double
    var total : Double
    var imageURL : String
    var priority : Int
    
    // basket
    var countInBasket : Int?
}

extension BundleOffer {

    // get price string to display..
    func getPrice() -> String {
        return "£" + String(format: "%.2f", getTotalPrice())
    }
    
    // get price in basket..
    func getPriceInBasket() -> String {
        guard let count = countInBasket else {return ""}
        return "£" + String(format: "%.2f", getTotalPrice() * Double(count))
    }
    
    // check for additional amount of products in bundle items
    func getTotalPrice() -> Double {
        var total = self.total
        guard let items = self.items else {return total}
        for item in items {
            for product in item.products {
                if product.isSelectedBundleItem() {
                    total =  total + product.getAdditionalAmount()
                }
            }
        }
        return total
    }
    
}


extension BundleOffer {
    func getSelectedItemNames() -> String {
        var string = ""
        guard let items = items else {return string}
        for item in items {
            for product in item.products {
                if product.isSelectedBundleItem() {
                    if string.isEmpty {
                        string = string + product.name
                    } else {
                        string = string + ", " + product.name
                    }
                }
            }
        }
        return string
    }
}


struct BundleItem : Codable  {
    var title : String
    var products : [BundleProduct]
}


class BundleProduct : Codable {
    var id : String?
    var name : String
    var quicrPrice : Double
    var description : String?
    var categoryIds : [Int]
    var imageURL : String
    
    // additional amount
    var additionalAmount : Double?
    
    // for basket
    var countInBasket  : Int?
    
    // for availability
    var outOfStock  : Bool?
    var notAvailableforOrder : Bool?
    
    // for bundle case
    var isSelected : Bool?
    
    var optional : Bool?
    
    func getPrice() -> String {
        return "£" + String(format: "%.2f", quicrPrice)
    }
    
    func getAdditionAmountString() -> String {
        guard let additionAmount  = self.additionalAmount else  {return ""}
        return "+ £" + String(format: "%.2f", additionAmount)
    }
    
    func getPriceInBasket() -> String {
        guard let count = countInBasket else {return ""}
        return "£" + String(format: "%.2f", quicrPrice * Double(count))
    }
    
    func isSelectedBundleItem() -> Bool {
        guard let isSelected = self.isSelected else {return false}
        return isSelected
    }
    
    func getAdditionalAmount() -> Double {
        guard let additionalAmount = self.additionalAmount else {
            return 0.0
        }
        return additionalAmount
    }
    
    func isOptional() -> Bool {
        guard let optional = self.optional else {return false}
        return optional
    }
}

