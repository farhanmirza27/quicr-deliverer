
import UIKit

fileprivate let reuseIdentifier = "CompletedOrderCellId"

class CompletedOrdersViewController : BaseViewController {
    
    var viewModel = CompletedOrdersViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.startAnimating()
        viewModel.getCompletedOrders()
    }
    
    private func setupUI() {
        navigationItem.title = "Completed Orders"
        tableView.register(CompletedOrderCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}


extension CompletedOrdersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CompletedOrderCell
        cell.order  = viewModel.orders[indexPath.row]
        cell.configCell()
        return cell
    }
}

extension CompletedOrdersViewController : CompletedOrdersViewModelDelegate {
    func success() {
        self.stopAnimating()
        self.tableView.reloadData()
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
}
