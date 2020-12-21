//
//  HomeViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

private enum Section {
    case requests
    case orders
}

fileprivate let reuseIdentifier = "OrderCellId"

class HomeViewController : BaseViewController {
    
    private var sections : [Section] = [.requests,.orders]
    var orders = [Order]()
    var viewModel = HomeViewModel()
    var orderRequestInfo = "No new order requests"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        viewModel.delegate = self
        self.startAnimating()
        viewModel.loadData()
    }
    
    private func setupUI() {
        hideBackTitle()
        tableView.register(OrderCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "Deliverer App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "account"), style: .plain, target: self, action: #selector(didClickAccount))
    }
    
    @objc func didClickAccount() {
        self.navigationController?.pushViewController(AccountViewController(), animated: true)
    }
}

extension HomeViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .requests:
            return 1
        case .orders:
            return orders.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .requests:
            let cell = LabelCell()
            cell.titleLabel.text = orderRequestInfo
            cell.titleLabel.textColor = AppTheme.blue
            cell.accessoryType = .disclosureIndicator
            return cell
        case .orders:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OrderCell
            cell.order = orders[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .requests:
            self.navigationController?.pushViewController(OrderRequestsViewController(), animated: true)
        case .orders:
            let controller = OrderDetailViewController()
            controller.order = self.orders[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView()
        switch sections[section] {
        case .requests:
            headerView.headerLabel.text = "Order Requests"
        case .orders:
            headerView.headerLabel.text = "Active Orders"
        }
        return headerView
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}



extension HomeViewController : HomeViewModelDelegate {
    
    func newOrderRequests(orders: [Order]) {
        self.orderRequestInfo = "You have \(orders.count) new order requests"
        self.tableView.reloadData()
    }
    
    func success(orders: [Order]) {
        self.stopAnimating()
        self.orders = orders
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
}
