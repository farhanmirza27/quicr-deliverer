//
//  HomeViewModel.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//


protocol HomeViewModelDelegate {
    func newOrderRequests(orders : [Order])
    func success(orders : [Order])
    func failure(message : String)
}

class HomeViewModel {
    
    var delegate : HomeViewModelDelegate?
    
    func loadData() {
        loadOrders()
        loadNewOrdersRequests()
    }
    
    
    func loadNewOrdersRequests() {
        FirebaseClient.shared.loadOrderRequests { result in
            switch result {
            case .success(let orders):
                self.delegate?.newOrderRequests(orders: orders)
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
    
    func loadOrders() {
        FirebaseClient.shared.loadOrders { result in
            switch result {
            case .success(let orders):
                self.delegate?.success(orders: orders)
                self.addOrderObserver()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
    
    func addOrderObserver() {
        FirebaseClient.shared.addOrderObserver { result in
            switch result {
            case .success(let orders):
                self.delegate?.success(orders: orders)
                self.loadNewOrdersRequests()
            case .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}
