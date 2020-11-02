//
//  DataManager.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 29/10/2020.
//

import Foundation
import Disk

class DataManager {
    static let shared = DataManager()
    private init() {}
    
    func saveUser(user : User) {
        do { try Disk.save(user, to: .documents, as: "user.json")} catch {}
    }
    
    func getUser() -> User? {
        let user = try? Disk.retrieve("user.json", from: .documents, as: User.self)
        return user
    }
    
    func removeUser() {
        do {try Disk.remove("user.json", from: .documents)} catch {}
    }
}
