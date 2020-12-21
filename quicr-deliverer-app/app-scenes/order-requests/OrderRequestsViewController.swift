//
//  OrderRequestsViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import UIKit

fileprivate let reuseIdentifier = "OrderRequestCellId"
 
class OrderRequestsViewController : BaseViewController {
   
    var viewModel = OrderRequestsViewModel()
    var orderRequests = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.startAnimating()
        viewModel.loadOrderRequests()
    }
    
    private func setupUI() {
        navigationItem.title = "Order Requests"
        tableView.register(OrderRequestCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    @objc func didClickAccept(sender : UIButton) {
        self.startAnimating()
        self.viewModel.acceptOrder(order: self.orderRequests[sender.tag])
    }
}

extension OrderRequestsViewController {
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderRequests.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OrderRequestCell
        cell.acceptBtn.tag = indexPath.row
        cell.order = orderRequests[indexPath.row]
        cell.acceptBtn.addTarget(self, action: #selector(didClickAccept), for: .touchUpInside)
        return cell
    }
}


extension OrderRequestsViewController : OrderRequestsViewModelDelegate {
    func acceptOrderSucess(order : Order) {
        self.stopAnimating()
        if let index = self.orderRequests.firstIndex(where:{ $0.id == order.id }) {
            self.orderRequests.remove(at: index)
        }
        self.tableView.reloadData()
    }
    
    func success(requests: [Order]) {
        self.stopAnimating()
        self.orderRequests = requests
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
}
