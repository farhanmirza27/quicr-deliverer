//
//  OrderRequestsViewModel.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 28/10/2020.
//

import Foundation
import Firebase

protocol OrderRequestsViewModelDelegate {
    func acceptOrderSucess(order : Order)
    func success(requests : [Order])
    func failure(message : String)
}

class OrderRequestsViewModel {
    
    var delegate : OrderRequestsViewModelDelegate?
    
    func loadOrderRequests() {
        FirebaseClient.shared.loadOrderRequests { result in
            switch result {
            case .success(let orders):
                self.delegate?.success(requests: orders)
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
    
    func acceptOrder(order : Order) {
        var order = order
        guard let userId = Auth.auth().currentUser?.uid else {return}
        order.delivererId = userId
        order.status = OrderStatus.accepted
        FirebaseClient.shared.acceptOrder(order: order) { result in
            switch result {
            case .success(_):
                guard let orderId = order.id else {return}
                PushNotificationSender().sendPushNotification(to: order.userId, title: "Order Update", body: "Your order has been accepted", orderId: orderId)
                self.delegate?.acceptOrderSucess(order : order)
            case .failure(let error):
            self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
