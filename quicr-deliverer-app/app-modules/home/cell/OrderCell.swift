//
//  OrderCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

class OrderCell : TableViewBaseCell {
    
    var statusLabel = UIComponents.shared.label(text: "ACCEPTED",fontName: FontName.Bold,fontSize: 13,color: AppTheme.primaryColor)
    var deliveryAddress = UIComponents.shared.label(text: "134 Central Park Road, London, E63DN",fontSize: 13)
    var deliverAtLabel = UIComponents.shared.label(text: "Delivery Address:",fontName: FontName.Bold,fontSize: 13,color: AppTheme.blue)
    var totalLabel = UIComponents.shared.label(text: "£34.56",fontName: FontName.Bold)
    var container = UIComponents.shared.container(bgColor: .white, cornerRadius: 10)
    var arrowIcon = UIComponents.shared.ImageView(imageName : "arrow-head")
    
    
    var order : Order? {
        didSet {
            guard let order = order else {return}
            statusLabel.text = order.status.rawValue
            deliveryAddress.text = order.customerAddress.getAddressString()
            totalLabel.text = order.getTotal()
        }
    }
    
    override func setupUI() {
        container.addShadow()
        removeSeparator()
        addSubViews(views: container)
        container.addSubViews(views: statusLabel,deliverAtLabel,deliveryAddress,totalLabel,arrowIcon)
        NSLayoutConstraint.activate([
            
            statusLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 16),
            statusLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 16),
            totalLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -16),
            totalLabel.topAnchor.constraint(equalTo: statusLabel.topAnchor),
            
            deliverAtLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor,constant: 20),
            deliverAtLabel.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            deliverAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -40),
            
            deliveryAddress.topAnchor.constraint(equalTo: deliverAtLabel.bottomAnchor,constant: 4),
            deliveryAddress.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            deliveryAddress.trailingAnchor.constraint(equalTo: deliverAtLabel.trailingAnchor),
            
            container.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            container.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            container.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            container.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 0),
            container.heightAnchor.constraint(equalToConstant: 130),
            
            arrowIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            arrowIcon.widthAnchor.constraint(equalToConstant: 20),
            arrowIcon.heightAnchor.constraint(equalToConstant: 20),
            arrowIcon.trailingAnchor.constraint(equalTo: container.trailingAnchor,constant: -16)
            
        ])
    }
}
