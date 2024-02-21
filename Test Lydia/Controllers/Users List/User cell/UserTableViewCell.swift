//
//  UserTableViewCell.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit

/// Displayed in UsersListViewController, presents a user's basic information (Profile picture, full name and address)
class UserTableViewCell: UITableViewCell {
    
    var roundedBackgroundView: UIView!
    var nameLabel: UILabel!
    var addressLabel: UILabel!
    var profilePictureImageView: ProgressiveImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()

        // Operates changes when the user switches display mode (Dark or Light)
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) {
            (self: Self, previousTraitCollection: UITraitCollection) in
            self.roundedBackgroundView.layer.borderColor = Theme.Cell.borderColor.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Resets the cell to its original state
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = ""
        self.addressLabel.text = ""
        self.profilePictureImageView.reset()
    }
    
    // Setting up all constraints and creating UI elements instances
    private func prepareUI() {
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        let roundedBackgroundView = UIView()
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: -4),
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -16),
        ])
        
        roundedBackgroundView.layer.cornerRadius = Theme.Cell.cornerRadius
        roundedBackgroundView.backgroundColor = Theme.Cell.backgroundColor
        roundedBackgroundView.layer.borderWidth = Theme.Cell.borderWidth
        roundedBackgroundView.layer.borderColor = Theme.Cell.borderColor.cgColor
        
        self.roundedBackgroundView = roundedBackgroundView
        
        let imageView = ProgressiveImageView(size: .large)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)
        self.profilePictureImageView = imageView
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .top, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .trailing, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .bottom, multiplier: 1, constant: -8),
        ])
        
        let nameLabel = UILabel()
        nameLabel.font = Theme.Cell.titleFont
        nameLabel.textColor = Theme.Cell.titleColor
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .top, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: imageView, attribute: .leading, multiplier: 1, constant: 8),
        ])
        
        let addressLabel = UILabel()
        addressLabel.font = Theme.Cell.subtitleFont
        addressLabel.textColor = Theme.Cell.subtitleColor
        addressLabel.numberOfLines = 3
        addressLabel.minimumScaleFactor = 0.5
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(addressLabel)
        self.addressLabel = addressLabel
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: addressLabel, attribute: .bottom, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .bottom, multiplier: 1, constant: -16),
            NSLayoutConstraint(item: addressLabel, attribute: .leading, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: addressLabel, attribute: .trailing, relatedBy: .equal, toItem: imageView, attribute: .leading, multiplier: 1, constant: -8),
        ])
        
    }
    
    // Sets the cell's user data and displays it
    func setUser(user: User) {
        self.nameLabel.text = user.name?.formattedName()
        self.addressLabel.text = user.location?.formattedAddress()
        
        profilePictureImageView.loadPicture(picture: user.picture)
    }

}
