//
//  FirebaseClient.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirebaseClientAuthProtocol {
    func userLoggedIn() -> Bool
    func signIn(email : String, password: String, completion : @escaping (Result<Bool,Error>) -> Void)
    func saveUserInfo(user : User, completion : @escaping (Result<Bool,Error>) -> Void)
    func getUserInfo(uid : String,completion : @escaping (Result<User,Error>) -> Void)
    func updateDeviceToken(token: String)
    func updateDelivererTokens(token: String)
    func signout()
}

enum FirebaseDocRefs : String {
    case users
    case orders
    case deviceTokens
}

class FirebaseClient : FirebaseClientAuthProtocol {

    let db = Firestore.firestore()
    private var tempVerificationId = ""
    static let shared = FirebaseClient()
    private init() {}
    
    
    func userLoggedIn() -> Bool {
        guard let _ = Auth.auth().currentUser else {
            return false
        }
        return true
    }
    
    func signIn(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { data,error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                if let uid = data?.user.uid {
                    PushNotificationManager().registerForPushNotifications()
                    self.getUserInfo(uid: uid) { result in
                        switch result {
                        case .success(_):
                        completion(.success(true))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
    }
    

    func saveUserInfo(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {return}
        do {
            try db.collection(FirebaseDocRefs.users.rawValue).document(id).setData(from: user, completion: {error in
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    DataManager.shared.saveUser(user: user)
                    completion(.success(true))
                }
            })
        }
        catch let error {
            completion(.failure(error))
        }
    }
    
  
    
    func getUserInfo(uid : String,completion : @escaping (Result<User,Error>) -> Void) {
        db.collection(FirebaseDocRefs.users.rawValue).document(uid).getDocument { (data, error) in
            if let error = error {
                completion(.failure(error))
            }
            else {
                if let data = data?.data() {
                    let user = try! Firestore.Decoder().decode(User.self, from: data)
                    DataManager.shared.saveUser(user: user)
                    completion(.success(user))
                }
                else {
                    completion(.failure(NSError(domain: "no user found", code: 0, userInfo: nil)))
                }
            }
        }
    }
    
    func updateDelivererTokens(token : String) {
        let deviceToken = DeviceToken(token: token)
        do {
           _ = try db.collection(FirebaseDocRefs.deviceTokens.rawValue).addDocument(from:deviceToken)
        }
        catch let error {
            print(error)
        }
    
    }
    
    func updateDeviceToken(token: String) {
        if let user = Auth.auth().currentUser {
            db.collection(FirebaseDocRefs.users.rawValue).document(user.uid).updateData(["deviceToken" : token])
            updateDelivererTokens(token: token)
        }
    }
    

    
    func signout() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


/// device token
struct DeviceToken : Codable {
    let token : String
}
