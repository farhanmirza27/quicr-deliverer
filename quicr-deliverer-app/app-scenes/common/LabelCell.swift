//
//  LabelCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

class LabelCell : TableViewBaseCell {
     
    var titleLabel = UIComponents.shared.label(text: "")
    
    override func setupUI() {
        addSubViews(views: titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16)
        ])
    }
}

