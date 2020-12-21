//
//  BundleOfferCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 17/11/2020.
//

import UIKit

class BundleOfferCell : TableViewBaseCell {
    
    var bundleOfferImage = UIComponents.shared.ImageView(imageName: "",contentMode: .scaleAspectFit)
    var nameLabel = UIComponents.shared.label(text: "",fontName: FontName.SemiBold,fontSize: 13)
    var priceLabel = UIComponents.shared.label(text: "",alignment: .right,fontName: FontName.SemiBold,fontSize: 13, color: AppTheme.primaryColor)
    var descriptionLabel =  UIComponents.shared.label(text: "",fontName: FontName.Regular,fontSize: 11)
    var countLabel = UIComponents.shared.label(text: "",alignment: .center,fontName: FontName.SemiBold)
    
    
    var count = 0
    
    var bundleOffer : BundleOffer? {
        didSet {
            guard let bundleOffer = bundleOffer else {return}
            nameLabel.text = bundleOffer.name
            priceLabel.text = bundleOffer.getPriceInBasket()
            bundleOfferImage.cacheImage(imageUrl: bundleOffer.imageURL)
            descriptionLabel.text = bundleOffer.getSelectedItemNames()
            guard let countInBasket = bundleOffer.countInBasket else {return}
            countLabel.text = "\(countInBasket)  x"
        }
    }
    
    override func setupUI() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.sizeToFit()
        
        addSubViews(views: bundleOfferImage,nameLabel,priceLabel,countLabel,descriptionLabel)
        NSLayoutConstraint.activate([
            
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: bundleOfferImage.centerYAnchor),
            countLabel.widthAnchor.constraint(equalToConstant: 25),
            
            bundleOfferImage.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor,constant: 16),
            bundleOfferImage.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            bundleOfferImage.widthAnchor.constraint(equalToConstant: 40),
            bundleOfferImage.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.leadingAnchor.constraint(equalTo: bundleOfferImage.trailingAnchor,constant: 16),
            nameLabel.topAnchor.constraint(equalTo: bundleOfferImage.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor,constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -30),
            priceLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
