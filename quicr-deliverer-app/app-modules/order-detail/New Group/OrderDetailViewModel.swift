//
//  OrderDetailViewModel.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 28/10/2020.
//

import Foundation

protocol OrderDetailViewModelDelegate {
    func chargeCustomerSuccess()
    func updateOrder(order : Order)
    func failure(message : String)
}

class OrderDetailViewModel {
    var delegate : OrderDetailViewModelDelegate?
    
    // Charge Customer..
    func chargeCustomer(order : Order) {
        guard let customerId = order.stripeCustomerId, let paymentId = order.stripePaymentId else {return}
        let total = order.total.rounded()
        ApiClient.shared.processPayment(customerId: customerId, paymentId: paymentId, amount:  total) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.updateOrder(order: order)
                case .failure(let error):
                    self.delegate?.failure(message: error.localizedDescription)
                }
            }
        }
    }
}

//MARK: Observers
extension OrderDetailViewModel {
    func addOrderObserver(orderId : String) {
        FirebaseClient.shared.trackOrder(orderId: orderId) { result in
            switch result {
            case .success(let order):
                self.delegate?.updateOrder(order: order)
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}

//MARK: Update Order
extension OrderDetailViewModel {
   private func updateOrder(order : Order) {
        var order = order
        order.customerCharged = true
        FirebaseClient.shared.updateOrder(order: order) { result in
            switch result {
            case .success(_):
            self.delegate?.chargeCustomerSuccess()
            case .failure(let error):
            self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
