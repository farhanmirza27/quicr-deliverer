//
//  Address.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 02/11/2020.
//

struct Address : Codable {
    var line_1 : String
    var line_2 : String
    var town_or_city : String
    var district : String
    var formatted_address : [String]
    
    var postcode : String?
    var lat : Double?
    var lng : Double?
    
    func getAddressString() -> String {
        var addressLine = line_1
        if !line_2.isEmpty {
            addressLine = addressLine + ", " + line_2
        }
        guard let postcode = postcode else {return addressLine}
        return addressLine + ",\n" + postcode + ", " + town_or_city
    }
}
