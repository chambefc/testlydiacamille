//
//  UserDetailsTextTableViewCell.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit

/// Used in UserDetails View Controller's tableView.
/// Allows to visualize inline given key and value
final class UserDetailsTextTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var informationLabel: UILabel!

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
        
        let titleLabel = UILabel()
        titleLabel.textColor = Theme.DetailsCell.color
        titleLabel.font = Theme.DetailsCell.font
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 4),
            NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self.contentView, attribute: .width, multiplier: 0.5, constant: 0),
        ])
        
        let informationLabel = UILabel()
        informationLabel.textColor = Theme.DetailsCell.color
        informationLabel.font = Theme.DetailsCell.font
        informationLabel.numberOfLines = 0
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        informationLabel.textAlignment = .right
        informationLabel.lineBreakMode = .byWordWrapping
        self.contentView.addSubview(informationLabel)
        self.informationLabel = informationLabel
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: informationLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 2),
            NSLayoutConstraint(item: informationLabel, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self.contentView, attribute: .width, multiplier: 0.6, constant: 0),
            NSLayoutConstraint(item: informationLabel, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: informationLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -4),
            NSLayoutConstraint(item: informationLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -2),
            NSLayoutConstraint(item: informationLabel, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: titleLabel, attribute: .height, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.informationLabel, attribute: .centerY, multiplier: 1, constant: 0),
        ])
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = Theme.DetailsCell.color.withAlphaComponent(0.3)
        self.contentView.addSubview(line)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: line, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: line, attribute: .trailing, relatedBy: .equal, toItem: informationLabel, attribute: .leading, multiplier: 1, constant: -8),
            NSLayoutConstraint(item: line, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1, constant: 0),
        ])
    }
    
    // Sets the cell's data and displays it
    func setData(title: String, value: String?) {
        self.titleLabel.text = title
        self.informationLabel.text = value
    }

}
