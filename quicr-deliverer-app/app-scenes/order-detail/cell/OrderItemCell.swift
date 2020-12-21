//
//  OrderItemCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

class OrderItemCell : TableViewBaseCell {
    
    var productImage = UIComponents.shared.ImageView(imageName: "",contentMode: .scaleAspectFit)
    var nameLabel = UIComponents.shared.label(text: "",fontName: FontName.SemiBold,fontSize: 13)
    var priceLabel = UIComponents.shared.label(text: "",alignment: .right,fontName: FontName.SemiBold,fontSize: 13, color: AppTheme.primaryColor)
    var countLabel = UIComponents.shared.label(text: "",alignment: .center,fontName: FontName.SemiBold)
    let cover = UIComponents.shared.container(bgColor: .white)
    let notAvailableLabel =  UIComponents.shared.label(text: "Not Available",fontName: FontName.SemiBold,fontSize: 13,color: AppTheme.primaryColor)
    var count = 0
    
    var product : Product? {
        didSet {
            guard let product = product else {return}
            nameLabel.text = product.name
            priceLabel.text = product.getPrice()
            productImage.cacheImage(imageUrl: product.imageURL)
            guard let countInBasket = product.countInBasket else {return}
            countLabel.text = "\(countInBasket)  x"
            if let availableForOrder = product.notAvailableforOrder {
                if !availableForOrder {
                    self.markAsNotAvailable()
                }
                else {
                    self.markAsAvailable()
                }
            }
            else {
                self.markAsAvailable()
            }
        }
    }
    
    override func setupUI() {
        cover.alpha = 0.5
        contentView.addSubViews(views: productImage,nameLabel,priceLabel,countLabel,cover,notAvailableLabel)
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
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            
            // not available
            cover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cover.topAnchor.constraint(equalTo: contentView.topAnchor),
            cover.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            notAvailableLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            notAvailableLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16)
        ])
    }
    
    func markAsNotAvailable() {
        cover.isHidden = false
        notAvailableLabel.isHidden = false
    }
    
    func markAsAvailable() {
        cover.isHidden = true
        notAvailableLabel.isHidden = true
    }
}
