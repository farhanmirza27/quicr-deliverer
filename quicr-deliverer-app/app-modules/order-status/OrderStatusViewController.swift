//
//  OrderStatusViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit
import RadioGroup

class OrderStatusViewController : BaseViewController {
    var headerLabel = UIComponents.shared.label(text: "Update Order Status",alignment: .center,fontName: FontName.Bold)
    var container = UIComponents.shared.container(cornerRadius: 10)
    var radioGroup = RadioGroup(titles: [])
    var doneBtn = UIComponents.shared.button(title: "Done")
    var cancelBtn = UIComponents.shared.button(title: "Cancel")
    var viewModel = OrderStatusViewModel()
    
    var order : Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configRadioGroup()
        setupUI()
        viewModel.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.40)
        cancelBtn.backgroundColor = .clear
        cancelBtn.setTitleColor(AppTheme.blue, for: .normal)
        container.addSubViews(views: headerLabel,radioGroup,doneBtn,cancelBtn)
        view.addSubViews(views: container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            headerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 24),
            
            radioGroup.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            radioGroup.heightAnchor.constraint(equalToConstant: 40),
            radioGroup.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,constant: 16),
            
            doneBtn.heightAnchor.constraint(equalToConstant: 35),
            doneBtn.widthAnchor.constraint(equalToConstant: 120),
            doneBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            doneBtn.topAnchor.constraint(equalTo: radioGroup.bottomAnchor,constant: 35),
            
            cancelBtn.heightAnchor.constraint(equalToConstant: 35),
            cancelBtn.widthAnchor.constraint(equalToConstant: 120),
            cancelBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            cancelBtn.topAnchor.constraint(equalTo: doneBtn.bottomAnchor,constant: 16),
            cancelBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -24)
            
        ])
        
        cancelBtn.addTarget(self, action: #selector(didClickCancel), for: .touchUpInside)
        doneBtn.addTarget(self, action: #selector(didClickDone), for: .touchUpInside)
    }
    
    private func configRadioGroup() {
        guard let orderStatus = self.order?.status else {return}
        switch orderStatus {
        case .accepted:
        radioGroup = RadioGroup(titles: ["In Progress"])
        case .inProgress:
        radioGroup = RadioGroup(titles: ["Delivery In Progress"])
        case .deliveryInProgress:
        radioGroup = RadioGroup(titles: ["Delivered"])
        default:
        break
        }

        radioGroup.titleFont = UIFont(name: FontName.SemiBold, size: 13)
        radioGroup.tintColor = AppTheme.primaryColor
        radioGroup.spacing = 16
        radioGroup.itemSpacing = 16
        radioGroup.selectedIndex = 0
    }
    
    @objc func didClickDone() {
        guard let order = self.order else {return}
        var orderStatus = order.status
        switch orderStatus {
        case .accepted:
        orderStatus = .inProgress
        case .inProgress:
        orderStatus = .deliveryInProgress
        case .deliveryInProgress:
        orderStatus = .delivered
        default:
        break
        }
        self.startAnimating()
        viewModel.updateOrderStatus(order: order, status: orderStatus)
      
    }
    
    @objc func didClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension OrderStatusViewController : OrderStatusViewModelDelegate {
    func success() {
        self.stopAnimating()
        self.dismiss(animated: true, completion: nil)
    }
    
    func failure(message: String) {
        self.stopAnimating()
        self.alert(message: message)
    }
}
