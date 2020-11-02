//
//  AddressCell.swift
//  quicr-deliverer-app
//
//  Created by Farhan Mirza on 26/10/2020.
//

import UIKit
import MapKit

class AddressCell : TableViewBaseCell {
  
    var addressLabel = UIComponents.shared.label(text: "",fontSize: 13)
    var button = UIComponents.shared.buttonWithImage(imageName: "map")
    
    override func setupUI() {
        button.tintColor = AppTheme.blue
        contentView.addSubViews(views: addressLabel,button)
        NSLayoutConstraint.activate([
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            addressLabel.trailingAnchor.constraint(equalTo: button.leadingAnchor,constant: -20),
            
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        
        button.addTarget(self, action: #selector(didClickMap), for: .touchUpInside)
    }
}

extension AddressCell  {
    @objc func didClickMap() {
        let lat : Double =  51.528640
        let lng : Double =  0.040490
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 51.528430, longitude: 0.042790)))
        source.name = "Source"

        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng)))
        destination.name = "Destination"

        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
