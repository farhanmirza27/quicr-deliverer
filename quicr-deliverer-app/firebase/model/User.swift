//
//  User.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 29/10/2020.
//

struct User : Codable {
    var id : String?
    var fullName : String
    var phone : String
    var email : String
    var deviceToken : String?
}
