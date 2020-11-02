//
//  OrderDetailViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

private enum Section {
    case status
    case deliveryAddress
    case items
    case orderTotal
    case chargeCustomer
}

fileprivate let reuseIdentifier = "OrderItemCellId"

class OrderDetailViewController  : BaseViewController {
    
    private var sections : [Section] =  [.status,.deliveryAddress,.items,.orderTotal,.chargeCustomer]
    var order  : Order?
    var viewModel = OrderDetailViewModel()
    var chargeBtn = UIComponents.shared.button(title: "Charge Customer",fontSize: 13,bgColor: AppTheme.primaryColor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        guard let orderId = self.order?.id else {return}
        viewModel.delegate = self
        viewModel.addOrderObserver(orderId : orderId)
    }
    
    private func setupUI() {
        navigationItem.title = "Order Detail"
        tableView.register(OrderItemCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        chargeBtn.addTarget(self, action: #selector(didClickChargeCustomer), for: .touchUpInside)
    }
    
     @objc private func didClickChargeCustomer() {
        guard let order = self.order else {return}
        self.startAnimating()
        self.viewModel.chargeCustomer(order: order)
    }
}

extension OrderDetailViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .status,.deliveryAddress,.orderTotal,.chargeCustomer:
            return 1
        case .items:
            guard let orderItems = self.order?.items else {return 0}
            return orderItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .status:
            let cell = OrderStatusCell()
            cell.statusLabel.text = order?.status.rawValue.uppercased()
            cell.button.addTarget(self, action: #selector(didClickUpdateStatus), for: .touchUpInside)
            return cell
        case .deliveryAddress:
            let cell = AddressCell()
            cell.addressLabel.text = order?.customerAddress.getAddressString()
            return cell
        case .items:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OrderItemCell
            cell.product = self.order?.items[indexPath.row]
            cell.requestChangeBtn.tag = indexPath.row
            cell.requestChangeBtn.addTarget(self, action: #selector(didClickChangeOrCancel), for: .touchUpInside)
            return cell
        case .orderTotal:
            let cell = OrderTotalCell()
            cell.TotalLabel.text = self.order?.getTotal()
            cell.deliveryLabel.text = self.order?.getDeliveryFee()
            cell.subTotal.text = self.order?.getSubTotal()
            return cell
        case .chargeCustomer:
            let cell = UITableViewCell()
            cell.asBasicCell()
            cell.contentView.addSubViews(views: chargeBtn)
            NSLayoutConstraint.activate([
                chargeBtn.widthAnchor.constraint(equalToConstant: 140),
                chargeBtn.heightAnchor.constraint(equalToConstant: 40),
                chargeBtn.trailingAnchor.constraint(equalTo:   cell.contentView.trailingAnchor,constant: -16),
                chargeBtn.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 0),
                chargeBtn.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor,constant: -10)
            ])
            cell.removeSeparator()
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView()
        switch sections[section] {
        case .status:
            headerView.headerLabel.text = "Order Status"
        case .deliveryAddress:
            headerView.headerLabel.text = "Delivery Address"
        case .items:
            headerView.headerLabel.text = "Order Items"
        case .orderTotal:
            headerView.headerLabel.text = "Order Total"
        case .chargeCustomer:
            headerView.headerLabel.text = ""
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .chargeCustomer:
            return 10
        default:
            return 40
        }

    }
}


extension OrderDetailViewController {
    
    @objc func didClickUpdateStatus() {
        let controller = OrderStatusViewController()
        controller.order = self.order
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func didClickChangeOrCancel(sender : UIButton) {
        let controller = ChangeOrderItemViewController()
        controller.delegate = self
        controller.index = sender.tag
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true, completion: nil)
    }
}


extension OrderDetailViewController : OrderDetailViewModelDelegate {
    func chargeCustomerSuccess() {
        self.stopAnimating()
        self.alert(message: "Payment Processed Sucessfully")
        self.sections = [.status,.deliveryAddress,.items,.orderTotal]
        self.tableView.reloadData()
    }
    
    func updateOrder(order: Order) {
        self.stopAnimating()
        self.order = order
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }

}


//MARK: ChangeOrderItemDelegate
extension OrderDetailViewController : ChangeOrderItemDelegate {
    func markAsUnavailable(index: Int) {
        guard var order = self.order else {return}
        order.items[index].availableForOrder = false
        order.subTotal = order.getItemsTotal()
        order.total = order.getOrderTotal()
        self.viewModel.updateOrder(order: order)
    }
}
