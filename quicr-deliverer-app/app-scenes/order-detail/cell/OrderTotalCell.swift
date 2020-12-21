//
//  OrderTotalCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import UIKit

class OrderTotalCell : TableViewBaseCell {
    
    var subTotal =  UIComponents.shared.label(text: "SubTotal:  £0.0")
    var deliveryLabel = UIComponents.shared.label(text: "Delivery:  £0.0")
    var TotalLabel = UIComponents.shared.label(text: "Total:  £0.0",fontName: FontName.Bold)
    
    override func setupUI() {
        removeSeparator()
        addSubViews(views: subTotal,deliveryLabel,TotalLabel)
        NSLayoutConstraint.activate([
            subTotal.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            subTotal.topAnchor.constraint(equalTo: topAnchor,constant: 20),
          
            deliveryLabel.topAnchor.constraint(equalTo: subTotal.bottomAnchor,constant: 4),
            deliveryLabel.trailingAnchor.constraint(equalTo: subTotal.trailingAnchor),
            
            TotalLabel.topAnchor.constraint(equalTo: deliveryLabel.bottomAnchor,constant: 4),
            TotalLabel.trailingAnchor.constraint(equalTo: subTotal.trailingAnchor),
            TotalLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
        ])
    }
}
 
