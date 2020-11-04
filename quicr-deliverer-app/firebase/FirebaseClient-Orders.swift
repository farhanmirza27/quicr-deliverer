//
//  FirebaseClient-Orders.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import Foundation

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift



protocol FirebaseClientOrderProtocol {
    func acceptOrder(order : Order,completion: @escaping (Result<Bool, Error>) -> Void)
    func updateOrder(order : Order,completion: @escaping (Result<Bool, Error>) -> Void)
    func loadOrderRequests(completion : @escaping (Result<[Order],Error>) -> Void)
    func loadOrders(completion : @escaping (Result<[Order],Error>) -> Void)
    func addOrderObserver(completion: @escaping (Result<[Order], Error>) -> Void)
    func trackOrder(orderId : String,completion : @escaping (Result<Order,Error>) -> Void)
    func removeOrderObserver(orderId : String)
}


extension FirebaseClient : FirebaseClientOrderProtocol {
  
    func acceptOrder(order : Order,completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try db.collection(FirebaseDocRefs.orders.rawValue).document(order.id!).setData(from: order, completion: {error in
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    completion(.success(true))
                }
            })
        }
        catch let error {
            completion(.failure(error))
        }
    }

    func updateOrder(order: Order, completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try db.collection(FirebaseDocRefs.orders.rawValue).document(order.id!).setData(from: order, completion: {error in
                if let error = error {
                    completion(.failure(error))
                }
                else {
                    completion(.success(true))
                }
            })
        }
        catch let error {
            completion(.failure(error))
        }
    }

    func loadOrderRequests(completion : @escaping (Result<[Order],Error>) -> Void) {
        db.collection(FirebaseDocRefs.orders.rawValue).whereField("status", isEqualTo: OrderStatus.placed.rawValue).getDocuments { data,error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                  var orders = [Order]()
                guard let data = data else {return}
                  for doc in data.documents {
                    var order = try! Firestore.Decoder().decode(Order.self, from: doc.data())
                    order.id = doc.documentID
                    orders.append(order)
                  }
                completion(.success(orders))
            }
        }
    }
    
    
    
    func loadOrders(completion: @escaping (Result<[Order], Error>) -> Void) {
        db.collection(FirebaseDocRefs.orders.rawValue).getDocuments { data,error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                  var orders = [Order]()
                guard let data = data else {return}
                  for doc in data.documents {
                    var order = try! Firestore.Decoder().decode(Order.self, from: doc.data())
                    order.id = doc.documentID
                    if let _ = order.delivererId {
                    orders.append(order)
                    }
                  }
                completion(.success(orders))
            }
        }
    }
    
    func trackOrder(orderId : String,completion: @escaping (Result<Order, Error>) -> Void) {
        db.collection(FirebaseDocRefs.orders.rawValue).document(orderId).addSnapshotListener { document, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                guard let data = document?.data() else {return}
                let order = try! Firestore.Decoder().decode(Order.self, from: data)
                completion(.success(order))
            }
        }
    }
    
    func addOrderObserver(completion: @escaping (Result<[Order], Error>) -> Void) {
        db.collection(FirebaseDocRefs.orders.rawValue).addSnapshotListener { data, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                var orders = [Order]()
              guard let data = data else {return}
                for doc in data.documents {
                  var order = try! Firestore.Decoder().decode(Order.self, from: doc.data())
                  order.id = doc.documentID
                    if let _ = order.delivererId {
                    orders.append(order)
                    }
                }
              completion(.success(orders))
            }
        }
    }
    
    
    func removeOrderObserver(orderId: String) {
        let listener = db.collection(FirebaseDocRefs.orders.rawValue).document(orderId).addSnapshotListener { _,_ in
        }
        listener.remove()
    }
}

