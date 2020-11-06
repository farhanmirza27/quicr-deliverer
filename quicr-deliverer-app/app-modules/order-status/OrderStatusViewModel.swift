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
                PushNotificationSender().sendPushNotification(to: order.userId, title: "Order Update", body: status.rawValue, orderId: orderId)
                self.delegate?.success()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
