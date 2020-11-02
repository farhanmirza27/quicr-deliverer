//
//  StripeCustomer.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 29/10/2020.
//

struct StripeCustomer : Codable {
    var id : String
    var client_secret : String
    var customer : String
}


struct PaymentResponse : Codable {
    var success : Bool
}
