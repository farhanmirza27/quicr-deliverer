//
//  TableHeaderView.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit

class TableHeaderView : UIView {
   
    let headerLabel = UIComponents.shared.label(text: "Demo",fontName: FontName.Bold,fontSize: 14,color: AppTheme.primaryColor)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = AppTheme.bgColor
        addSubViews(views: headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
