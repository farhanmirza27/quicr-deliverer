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
    case bundleOffers
    case orderTotal
    case changeOrderItems
    case chargeCustomer
    case chargedInfo
}

fileprivate let reuseIdentifier = "OrderItemCellId"
fileprivate let bundleReuseIdentifier = "BundleOfferCellId"

class OrderDetailViewController  : BaseViewController {
    
    private var sections : [Section] =  [.status,.deliveryAddress,.items,.bundleOffers,.orderTotal,.changeOrderItems,.chargeCustomer]
    var order  : Order?
    var viewModel = OrderDetailViewModel()
    var changeOrderBtn = UIComponents.shared.button(title: "Not Available? Inform Customer",fontSize: 13,bgColor: AppTheme.blue)
    var chargeBtn = UIComponents.shared.button(title: "All Items Available. Charge Customer.",fontSize: 13,bgColor: AppTheme.primaryColor)
    
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
        tableView.register(BundleOfferCell.self, forCellReuseIdentifier: bundleReuseIdentifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        chargeBtn.addTarget(self, action: #selector(didClickChargeCustomer), for: .touchUpInside)
        changeOrderBtn.addTarget(self, action: #selector(didClickChangeOrCancel(sender:)), for: .touchUpInside)
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
        case .status,.deliveryAddress,.orderTotal,.changeOrderItems,.chargeCustomer:
            return 1
        case .chargedInfo:
            return 0
        case .items:
            guard let orderItems = self.order?.items else {return 0}
            return orderItems.count
        case .bundleOffers:
            guard let bundleOffers = self.order?.bundleOffer else {return 0}
            return bundleOffers.count
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
            return cell
        case .bundleOffers:
            let cell = tableView.dequeueReusableCell(withIdentifier: bundleReuseIdentifier, for: indexPath) as! BundleOfferCell
            cell.bundleOffer = self.order?.bundleOffer[indexPath.row]
            return cell
        case .orderTotal:
            let cell = OrderTotalCell()
            cell.TotalLabel.text = self.order?.getTotal()
            cell.deliveryLabel.text = self.order?.getDeliveryFee()
            cell.subTotal.text = self.order?.getSubTotal()
            return cell
        case .changeOrderItems:
            let cell = UITableViewCell()
            cell.asBasicCell()
            cell.contentView.addSubViews(views: changeOrderBtn)
            NSLayoutConstraint.activate([
                changeOrderBtn.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor,constant: 30),
                changeOrderBtn.heightAnchor.constraint(equalToConstant: 40),
                changeOrderBtn.trailingAnchor.constraint(equalTo:   cell.contentView.trailingAnchor,constant: -30),
                changeOrderBtn.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 0),
                changeOrderBtn.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor,constant: -10)
            ])
            cell.removeSeparator()
            return cell
        case .chargeCustomer:
            let cell = UITableViewCell()
            cell.asBasicCell()
            cell.contentView.addSubViews(views: chargeBtn)
            NSLayoutConstraint.activate([
                chargeBtn.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor,constant: 30),
                chargeBtn.heightAnchor.constraint(equalToConstant: 40),
                chargeBtn.trailingAnchor.constraint(equalTo:   cell.contentView.trailingAnchor,constant: -30),
                chargeBtn.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 0),
                chargeBtn.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor,constant: -10)
            ])
            cell.removeSeparator()
            return cell
        case .chargedInfo:
           return UITableViewCell()
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
        case .bundleOffers:
            headerView.headerLabel.text = "Bundle Offers"
        case .orderTotal:
            headerView.headerLabel.text = "Order Total"
        case .chargeCustomer,.changeOrderItems:
            headerView.headerLabel.text = ""
        case .chargedInfo:
            headerView.headerLabel.textAlignment = .right
            headerView.headerLabel.text = "Customer Charged for this order."
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .items:
            guard let orderItems = order?.items else {
                return 0
            }
            if orderItems.isEmpty {
                return 0
            }
            else {
                return 40
            }
        case .bundleOffers:
            guard let bundlerOffer = order?.bundleOffer else {
                return 0
            }
            if bundlerOffer.isEmpty {
                return 0
            }
            else {
                return 40
            }
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
        controller.order = self.order
        self.navigationController?.pushViewController(controller, animated: true)
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
        
        if let _ = order.customerCharged {
            sections = [.status,.deliveryAddress,.items,.bundleOffers,.orderTotal,.chargedInfo]
        }
        else {
            sections =  [.status,.deliveryAddress,.items,.bundleOffers,.orderTotal,.changeOrderItems,.chargeCustomer]
        }
        
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
}
