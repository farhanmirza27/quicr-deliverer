//
//  ChangeOrderItemViewController.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 27/10/2020.
//

import UIKit

protocol ChangeOrderItemDelegate {
    func markAsUnavailable(index : Int)
}

class ChangeOrderItemViewController : BaseViewController {
    var headerLabel = UIComponents.shared.label(text: "Inform Customer about Availability",alignment: .center,fontName: FontName.Bold)
    var container = UIComponents.shared.container(cornerRadius: 10)
    var notAvailableBtn = UIComponents.shared.button(title: "Mark as not available")
    var cancelBtn = UIComponents.shared.button(title: "Cancel")
    
    var index : Int?
    var delegate : ChangeOrderItemDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.40)
        cancelBtn.backgroundColor = .clear
        cancelBtn.setTitleColor(AppTheme.blue, for: .normal)
        container.addSubViews(views: headerLabel,notAvailableBtn,cancelBtn)
        view.addSubViews(views: container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            headerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            headerLabel.topAnchor.constraint(equalTo: container.topAnchor,constant: 24),

            notAvailableBtn.heightAnchor.constraint(equalToConstant: 35),
            notAvailableBtn.widthAnchor.constraint(equalToConstant: 160),
            notAvailableBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            notAvailableBtn.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,constant: 35),
        
            cancelBtn.heightAnchor.constraint(equalToConstant: 35),
            cancelBtn.widthAnchor.constraint(equalToConstant: 120),
            cancelBtn.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            cancelBtn.topAnchor.constraint(equalTo: notAvailableBtn.bottomAnchor,constant: 16),
            cancelBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -24)
 
        ])
        
        cancelBtn.addTarget(self, action: #selector(didClickCancel), for: .touchUpInside)
        notAvailableBtn.addTarget(self, action: #selector(didClickNotAvailable), for: .touchUpInside)
    }
 
    @objc func didClickNotAvailable() {
        guard let index = index else {return}
        self.delegate?.markAsUnavailable(index: index)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
