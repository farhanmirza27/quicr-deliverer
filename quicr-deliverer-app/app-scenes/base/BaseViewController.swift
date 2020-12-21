//
//  BaseViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 23/10/2020.
//

import UIKit

class BaseViewController : UIViewController {
   
    var tableView = UIComponents.shared.tableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBasicLayout()
    }
    
    private func setupBasicLayout() {
        view.backgroundColor = AppTheme.bgColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(didClickBack))
    }
    
     @objc func didClickBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupTableView() {
        tableView.separatorStyle = .singleLine
        view.addSubViews(views: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


extension BaseViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
