//
//  Constants.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 29/10/2020.
//

import Foundation
import UIKit

enum HttpRequest : String {
    case Delete = "delete"
    case Post   = "post"
    case Update = "put"
    case Get = "get"
}


extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
