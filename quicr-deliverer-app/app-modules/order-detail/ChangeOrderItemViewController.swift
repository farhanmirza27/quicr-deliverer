//
//  ChangeOrderItemViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import UIKit
import SimpleCheckbox

fileprivate let reuseIdentifier = "OrderItemCellId"

private enum Section {
    case info
    case items
    case actions
}

class ChangeOrderItemViewController : BaseViewController {
    private var sections : [Section] = [.info,.items,.actions]
    var order : Order?
    var viewModel = ChangeOrderItemViewModel()
    var confirmBtn = UIComponents.shared.button(title: "Confirm")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "Request Changes"
        tableView.register(ChangeOrderItemCell.self, forCellReuseIdentifier: reuseIdentifier)
        confirmBtn.addTarget(self, action: #selector(didClickConfirm), for: .touchUpInside)
    }
}


extension ChangeOrderItemViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .info:
        return 0
        case .items:
            return order?.items.count ?? 0
        case .actions:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section] {
        case .info:
        return UITableViewCell()
        case .items:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ChangeOrderItemCell
            cell.product = order?.items[indexPath.row]
            cell.checkbox.tag = indexPath.row
            cell.checkbox.addTarget(self, action: #selector(didTapCheckbox), for: .valueChanged)
            return cell
        case .actions:
            let cell = UITableViewCell()
            cell.asBasicCell()
            cell.contentView.addSubViews(views: confirmBtn)
            NSLayoutConstraint.activate([
                confirmBtn.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor,constant: 30),
                confirmBtn.heightAnchor.constraint(equalToConstant: 40),
                confirmBtn.trailingAnchor.constraint(equalTo:   cell.contentView.trailingAnchor,constant: -30),
                confirmBtn.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 0),
                confirmBtn.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor,constant: -10)
            ])
            cell.removeSeparator()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = TableHeaderView()
        switch sections[section] {
        case .info:
            headerView.headerLabel.text = "Mark Items which are currently not available"
            headerView.headerLabel.font = UIFont(name: FontName.Regular, size: 13)
            headerView.headerLabel.textColor = AppTheme.secondaryBlack
        case .items:
            headerView.headerLabel.text = "Order Items"
        case .actions:
            headerView.headerLabel.text = ""
        }
        return headerView
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .info:
        return 60
        case .items:
        return 40
        case .actions:
        return 10
        }
    }
}

extension ChangeOrderItemViewController {
    
    @objc func didTapCheckbox(sender : Checkbox) {
        if !viewModel.selectedItemIndexes.contains(sender.tag) {
            viewModel.selectedItemIndexes.append(sender.tag)
        }
        else {
            guard let index = viewModel.selectedItemIndexes.firstIndex(of: sender.tag) else {return}
            viewModel.selectedItemIndexes.remove(at: index)
        }
    }

    
    @objc func didClickConfirm() {
        guard let order  = self.order else {return}
        self.startAnimating()
        viewModel.updateOrder(order: order)
    }
}



extension ChangeOrderItemViewController : ChangeOrderItemViewModelDelegate {
    func success() {
        self.stopAnimating()
        self.navigationController?.popViewController(animated: true)
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
}
