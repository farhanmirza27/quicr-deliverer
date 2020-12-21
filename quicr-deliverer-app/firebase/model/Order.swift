//
//  Order.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import Foundation

enum OrderStatus : String , Codable {
    case placed = "Order Placed"
    case accepted = "Order Accepted"
    case inProgress = "Order In Progress"
    case deliveryInProgress = "Order On Way"
    case delivered = "Order Delivered"
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
    var customerEmail  : String
    var customerAddress : Address
    var status : OrderStatus
    var timeStamp : Date
    
    var bundleOffer : [BundleOffer]
    
    // stripe info
    var stripeCustomerId : String?
    var stripePaymentId  : String?
    var customerCharged  : Bool?
    
    // deliverer info
    var delivererId : String?
    var deliveryTime : Date
    
    // requires action
    var needUserAction : Bool?
    var actionStartTime : Date?
    var actionEndTime : Date?
    
    // deliverer device Token for notification
    var delivererDeviceToken : String?
}

extension Order {
    
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
        
        for item in bundleOffer {
            guard let countInBasket = item.countInBasket else {return 0}
            total = total + (item.total * Double(countInBasket))
        }
        
        return total
    }
    
    func getOrderTotal() -> Double {
       return getItemsTotal() + quicrFee
    }
    
    
    func getTotal() -> String {
        return "£" + String(format: "%.2f", getOrderTotal())
    }
    
    func getSubTotal() -> String {
        return "£" + String(format: "%.2f", getItemsTotal())
    }
    
    func getDeliveryFee() -> String {
        return "£" + String(format: "%.2f", quicrFee)
    }
    
    func getOrderDate() -> String {
        return timeStamp.toString(dateFormat: "HH:mm E, d MMM y")
    }
}
