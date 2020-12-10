//
//  OrderStatusViewModel.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 28/10/2020.
//


protocol OrderStatusViewModelDelegate {
    func success()
    func failure(message : String)
}

class OrderStatusViewModel {
    
    var delegate : OrderStatusViewModelDelegate?
    
    func updateOrderStatus(order : Order, status : OrderStatus) {
        var order = order
        order.status = status
        FirebaseClient.shared.updateOrder(order: order) { result in
            switch result {
            case .success(_):
                guard let orderId = order.id else {return}
                var bodyText = ""
                switch status {
                case .accepted:
                bodyText = "Your order has been accepted"
                case .placed:
                bodyText = "Your order has been placed"
                case .inProgress:
                bodyText = "Your order is in progress"
                case .deliveryInProgress:
                 bodyText = "Your order is on the way"
                case .delivered:
                bodyText = "Your order has been delivered."
                }
                PushNotificationSender().sendPushNotification(to: order.userId, title: "Order Update", body: bodyText, orderId: orderId)
                self.delegate?.success()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
