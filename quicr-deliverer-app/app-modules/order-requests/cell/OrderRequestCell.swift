//
//  OrderRequestCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import UIKit

class OrderRequestCell : TableViewBaseCell {
    
    var deliveryTimeLabel = UIComponents.shared.label(text: "",fontName: FontName.Bold,fontSize: 13,color: AppTheme.primaryColor)
    var deliveryAddress = UIComponents.shared.label(text: "",fontSize: 13)
    var deliverAtLabel = UIComponents.shared.label(text: "",fontName: FontName.Bold,fontSize: 13,color: AppTheme.blue)
    var totalLabel = UIComponents.shared.label(text: "",fontName: FontName.Bold)
    var container = UIComponents.shared.container(bgColor: .white, cornerRadius: 10)
    var acceptBtn = UIComponents.shared.button(title: "Accept Order",fontSize: 13)
    
    var order : Order? {
        didSet {
            guard let order = order else {return}
            deliveryAddress.text = order.customerAddress.getAddressString()
            totalLabel.text = order.getTotal()
            deliveryTimeLabel.text = "Deliver Today at \(order.deliveryTime.toString(dateFormat: "HH:mm"))"
        }
    }
    
    override func setupUI() {
        container.addShadow()
        removeSeparator()
        contentView.addSubViews(views: container)
        container.addSubViews(views: deliveryTimeLabel,deliverAtLabel,deliveryAddress,totalLabel,acceptBtn)
        NSLayoutConstraint.activate([
            
            deliveryTimeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 16),
            deliveryTimeLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 16),
            totalLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -16),
            totalLabel.topAnchor.constraint(equalTo: deliveryTimeLabel.topAnchor),
            
            deliverAtLabel.topAnchor.constraint(equalTo: deliveryTimeLabel.bottomAnchor,constant: 20),
            deliverAtLabel.leadingAnchor.constraint(equalTo: deliveryTimeLabel.leadingAnchor),
            deliverAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            
            deliveryAddress.topAnchor.constraint(equalTo: deliverAtLabel.bottomAnchor,constant: 4),
            deliveryAddress.leadingAnchor.constraint(equalTo: deliveryTimeLabel.leadingAnchor),
            deliveryAddress.trailingAnchor.constraint(equalTo: deliverAtLabel.trailingAnchor),
            
            acceptBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -16),
            acceptBtn.heightAnchor.constraint(equalToConstant: 35),
            acceptBtn.widthAnchor.constraint(equalToConstant: 120),
            acceptBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -16),
            
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            container.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0),
            container.heightAnchor.constraint(equalToConstant: 160),
    
        ])
    }
}
