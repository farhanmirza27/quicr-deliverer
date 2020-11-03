//
//  Order.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import Foundation

enum OrderStatus : String , Codable {
    case placed = "Placed"
    case accepted = "Accepted"
    case inProgress = "InProgress"
    case deliveryInProgress = "Order On Way"
    case delivered = "Delivered"
}

struct Order : Codable {
    var id   : String?
    var items : [Product]
    var orderNum : String
    var subTotal : Double
    var total : Double
    var quicrFee : Double
    var userId : String
    var customerName   : String
    var customerPhone  : String
    var customerAddress : Address
    var status : OrderStatus
    var timeStamp : Date
    
    // stripe info
    var stripeCustomerId : String?
    var stripePaymentId  : String?
    
    // deliverer info
    var delivererId : String?
    
    func getItemsTotal() -> Double {
        var total : Double = 0.0
        for item in items {
            guard let countInBasket = item.countInBasket else {return 0}
            if let _ = item.notAvailableforOrder {
                // don't count its price
            }
            else {
                total = total + (item.quicrPrice * Double(countInBasket))
            }
        }
        return total
    }
    
    func getOrderTotal() -> Double {
       return getItemsTotal() + quicrFee
    }
    
    
    func getTotal() -> String {
        return "£" + String(format: "%.2f", total)
    }
    
    func getSubTotal() -> String {
        return "£" + String(format: "%.2f", subTotal)
    }
    
    func getDeliveryFee() -> String {
        return "£" + String(format: "%.2f", quicrFee)
    }
    func getOrderDate() -> String {
        return timeStamp.toString(dateFormat: "HH:mm E, d MMM y")
    }
}
