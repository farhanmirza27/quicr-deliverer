//
//  ChangeOrderItemCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 03/11/2020.
//

import UIKit
import SimpleCheckbox
class ChangeOrderItemCell : OrderItemCell {
    
    var checkbox = Checkbox()
    
    override func setupUI() {
        cover.alpha = 0.5
        notAvailableLabel.text = "Removed"
        configCheckbox()
        nameLabel.numberOfLines = 2
        nameLabel.sizeToFit()
        contentView.addSubViews(views: productImage,nameLabel,priceLabel,countLabel,checkbox,cover,notAvailableLabel)
        NSLayoutConstraint.activate([
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: productImage.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 25),
            
            productImage.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor,constant: 16),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20),
            productImage.widthAnchor.constraint(equalToConstant: 40),
            productImage.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor,constant: 16),
            nameLabel.topAnchor.constraint(equalTo: productImage.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor,constant: -20),
            
            priceLabel.trailingAnchor.constraint(equalTo: checkbox.leadingAnchor,constant: -20),
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            
            checkbox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            checkbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkbox.widthAnchor.constraint(equalToConstant: 20),
            checkbox.heightAnchor.constraint(equalToConstant: 20),
            
            // not available
            cover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cover.topAnchor.constraint(equalTo: contentView.topAnchor),
            cover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            notAvailableLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            notAvailableLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16)
        ])
    }
    
    private func configCheckbox() {
        checkbox.borderLineWidth = 2.5
        checkbox.borderStyle = .circle
        checkbox.uncheckedBorderColor = AppTheme.primaryColor
        checkbox.checkedBorderColor = AppTheme.primaryColor
        checkbox.checkmarkStyle = .tick
        checkbox.checkmarkColor = AppTheme.primaryColor
    }
    
    override func markAsAvailable() {
        super.markAsAvailable()
        checkbox.isHidden = false
        checkbox.isEnabled = true
        
    }
    
    override func markAsNotAvailable() {
        super.markAsNotAvailable()
        checkbox.isHidden = true
        checkbox.isEnabled = false
    }
}

