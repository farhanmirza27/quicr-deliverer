//
//  ChangeOrderItemViewModel.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 03/11/2020.
//

import Foundation

protocol ChangeOrderItemViewModelDelegate {
    func success()
    func failure(message : String)
}

class ChangeOrderItemViewModel {
    var selectedItemIndexes = [Int]()
    var delegate : ChangeOrderItemViewModelDelegate?
    
    func updateOrder(order : Order) {
        var order = order
        for index in selectedItemIndexes {
            order.items[index].notAvailableforOrder = false
        }
        order.subTotal = order.getItemsTotal()
        order.total = order.getOrderTotal()
        FirebaseClient.shared.updateOrder(order: order) { result in
            switch result {
            case .success(_):
                PushNotificationSender().sendPushNotification(to: order.userId, title: "We Need Your Action.", body: "Some of your order items are not available. Please update your order for replacement.")
            self.delegate?.success()
            case .failure(let error):
            self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
