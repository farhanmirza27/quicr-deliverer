//
//  OrderItemCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

class OrderItemCell : TableViewBaseCell {
    
    var productImage = UIComponents.shared.ImageView(imageName: "test",contentMode: .scaleAspectFit)
    var nameLabel = UIComponents.shared.label(text: "Kp Hula Hoops Salt & Vinegar 6X24g",fontName: FontName.SemiBold,fontSize: 13)
    var priceLabel = UIComponents.shared.label(text: "£2.38",alignment: .right,fontName: FontName.SemiBold,fontSize: 13, color: AppTheme.primaryColor)
    var countLabel = UIComponents.shared.label(text: "1  x",alignment: .center,fontName: FontName.SemiBold)
    var requestChangeBtn = UIComponents.shared.button(title: "Change / Cancel",fontSize: 12)
    let cover = UIComponents.shared.container(bgColor: .white)
    var count = 0
    
    var product : Product? {
        didSet {
            guard let product = product else {return}
            nameLabel.text = product.name
            priceLabel.text = product.getPrice()
            productImage.cacheImage(imageUrl: product.imageURL)
            guard let countInBasket = product.countInBasket else {return}
            countLabel.text = "\(countInBasket)  x"
            if let availableForOrder = product.availableForOrder {
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
        
        contentView.addSubViews(views: productImage,nameLabel,priceLabel,countLabel,requestChangeBtn)
        NSLayoutConstraint.activate([
            
            countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: productImage.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 25),
            
            productImage.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor,constant: 16),
            productImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -60),
            productImage.widthAnchor.constraint(equalToConstant: 40),
            productImage.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor,constant: 16),
            nameLabel.topAnchor.constraint(equalTo: productImage.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor,constant: -20),
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),
            
            requestChangeBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            requestChangeBtn.heightAnchor.constraint(equalToConstant: 35),
            requestChangeBtn.widthAnchor.constraint(equalToConstant: 120),
            requestChangeBtn.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16)
            
            
        ])
    }
}


extension OrderItemCell {
    func markAsNotAvailable() {
        contentView.addSubViews(views: cover)
        
        requestChangeBtn.setTitle("Not Available", for: .normal)
        requestChangeBtn.backgroundColor = .clear
        requestChangeBtn.setTitleColor(AppTheme.red, for: .normal)
        requestChangeBtn.bringSubviewToFront(cover)
        
        cover.alpha = 0.5
        NSLayoutConstraint.activate([
            cover.topAnchor.constraint(equalTo: topAnchor),
            cover.leadingAnchor.constraint(equalTo: leadingAnchor),
            cover.bottomAnchor.constraint(equalTo: bottomAnchor),
            cover.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func markAsAvailable() {
        cover.removeFromSuperview()
        requestChangeBtn.setTitle("Change / Cancel", for: .normal)
        requestChangeBtn.backgroundColor = AppTheme.blue
        requestChangeBtn.setTitleColor(.white, for: .normal)
    }
}
