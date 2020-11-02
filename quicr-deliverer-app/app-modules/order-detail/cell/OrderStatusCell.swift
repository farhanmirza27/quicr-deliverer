//
//  OrderStatusCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

class OrderStatusCell : TableViewBaseCell {
  
    var statusLabel = UIComponents.shared.label(text: "IN PROGRESS",fontName: FontName.SemiBold,fontSize: 12,color: AppTheme.blue)
    var button = UIComponents.shared.button(title: "Update Status",fontSize: 12)
    
    override func setupUI() {
        contentView.addSubViews(views: statusLabel,button)
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            statusLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            
            button.heightAnchor.constraint(equalToConstant: 35),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
