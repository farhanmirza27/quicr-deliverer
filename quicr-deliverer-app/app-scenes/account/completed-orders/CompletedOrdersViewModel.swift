

protocol CompletedOrdersViewModelDelegate {
    func success()
    func failure(message : String)
}

class CompletedOrdersViewModel {
    var orders = [Order]()
    var delegate : CompletedOrdersViewModelDelegate?
    func getCompletedOrders() {
        FirebaseClient.shared.loadOrders { result in
            switch result {
            case .success(let orders):
            self.orders = orders.sorted(by: { $0.timeStamp.compare($1.timeStamp) == .orderedAscending}).filter({ $0.status != OrderStatus.delivered})
            self.delegate?.success()
            case  .failure(let error):
                self.delegate?.failure(message: error.localizedDescription)
            }
        }
    }
}

