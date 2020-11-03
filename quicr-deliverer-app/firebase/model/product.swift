//
//  product.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

struct Product : Codable {
    var id : String?
    var name : String
    var quicrPrice : Double
    var description : String?
    var categoryIds : [Int]
    var imageURL : String
    // for basket
    var countInBasket  : Int?
    
    // for availability
    var outOfStock  : Bool?
    var notAvailableforOrder : Bool?
    
    
    func getPrice() -> String {
        return "£" + String(format: "%.2f", quicrPrice)
    }
}
