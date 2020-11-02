//
//  AccountViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import UIKit

private enum Row {
    case completedOrders
    case myDetails
    case notifications
    case logout
}

class AccountViewController : BaseViewController {
    var logoutBtn = UIComponents.shared.secondaryButton(title: "Logout")
    private var rows : [Row] = [.completedOrders,.myDetails,.notifications,.logout]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.title = "My Account"
        logoutBtn.addTarget(self, action: #selector(didClickLogout), for: .touchUpInside)
    }
    
    @objc func didClickLogout() {
        FirebaseClient.shared.signout()
        UIApplication.shared.windows.first?.rootViewController = LoginViewController()
    }
}

extension AccountViewController {
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LabelCell()
        cell.titleLabel.font = UIFont(name: FontName.Regular, size: 13)
        cell.accessoryType = .disclosureIndicator
        switch rows[indexPath.row] {
        case .completedOrders:
        cell.titleLabel.text = "Completed Orders"
        case .myDetails:
        cell.titleLabel.text = "My Details"
        case .notifications:
        cell.titleLabel.text = "Notifications"
        case .logout:
        let cell = UITableViewCell()
            cell.removeSeparator()
            cell.asBasicCell()
            cell.contentView.addSubViews(views: logoutBtn)
            NSLayoutConstraint.activate([
                logoutBtn.widthAnchor.constraint(equalToConstant: 100),
                logoutBtn.heightAnchor.constraint(equalToConstant: 35),
                logoutBtn.topAnchor.constraint(equalTo: cell.contentView.topAnchor,constant: 30),
                logoutBtn.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
                logoutBtn.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor)
            ])
            return cell
        }
        return cell
    }
}

