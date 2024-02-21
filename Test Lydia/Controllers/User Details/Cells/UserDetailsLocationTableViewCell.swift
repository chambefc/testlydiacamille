//
//  UserDetailsLocationTableViewCell.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit
import MapKit

/// Displays the user location textually as well as a small Map using the provided latitude and longitude
final class UserDetailsLocationTableViewCell: UITableViewCell {
    
    var stackView: UIStackView!
    var addressLabel: UILabel!
    var map: MKMapView!
    var coordinatesLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Setting up all constraints and creating UI elements instances
    private func prepareUI() {
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stackView)
        self.stackView = stackView
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: 0),
        ])
        
        let addressLabel = UILabel()
        addressLabel.textColor = Theme.DetailsCell.color
        addressLabel.font = Theme.DetailsCell.font
        addressLabel.numberOfLines = 0
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(addressLabel)
        self.addressLabel = addressLabel
        
        let map = MKMapView()
        map.layer.cornerRadius = 10
        map.translatesAutoresizingMaskIntoConstraints = false
        map.isUserInteractionEnabled = false
        self.map = map
        self.stackView.addArrangedSubview(map)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: map, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        ])
        
        let coordinatesLabel = UILabel()
        coordinatesLabel.textColor = Theme.DetailsCell.color
        coordinatesLabel.font = Theme.DetailsCell.coordinates
        coordinatesLabel.numberOfLines = 1
        coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(coordinatesLabel)
        self.coordinatesLabel = coordinatesLabel
        
    }
    
    // Sets the cell's user location data and displays it
    func setLocation(location: User.Location) {
        self.addressLabel.text = location.formattedAddress()
        guard let stringLatitude = location.coordinates?.latitude,
              let latitude = Double(stringLatitude),
              let stringLongitude = location.coordinates?.longitude,
              let longitude = Double(stringLongitude) else { return }
        self.map.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: true)
        coordinatesLabel.text = "Lat: \(latitude) | Long: \(longitude)"
    }

}
