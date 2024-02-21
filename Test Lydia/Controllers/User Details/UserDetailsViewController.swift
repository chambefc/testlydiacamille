//
//  UserDetailsViewController.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit

/// Displays a given User's details in a TableView
final class UserDetailsViewController: UIViewController {

    // MARK: - UI Elements
    var tableView: UITableView!
    var roundedBackgroundView: UIView!
    var profilePictureImageView: ProgressiveImageView!
    var nameLabel: UILabel!
    
    // MARK: - Private properties
    var viewModel: UserDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
        prepareTableView()

        // Operates changes when the user switches display mode (Dark or Light)
        registerForTraitChanges([UITraitUserInterfaceStyle.self]) {
            (self: Self, previousTraitCollection: UITraitCollection) in
            self.roundedBackgroundView.layer.borderColor = Theme.Cell.borderColor.cgColor
        }
    }

    private func prepareTableView() {

        tableView.register(UserDetailsTextTableViewCell.self, forCellReuseIdentifier: UserDetailsTextTableViewCell.reuseIdentifier)
        tableView.register(UserDetailsLocationTableViewCell.self, forCellReuseIdentifier: UserDetailsLocationTableViewCell.reuseIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 50
    }

    // Setting up all constraints and creating UI elements instances
    private func prepareUI() {
        
        let roundedBackgroundView = UIView()
        self.view.addSubview(roundedBackgroundView)
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 45),
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: roundedBackgroundView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
        ])
        
        roundedBackgroundView.layer.cornerRadius = Theme.Cell.cornerRadius
        roundedBackgroundView.backgroundColor = Theme.Cell.backgroundColor
        roundedBackgroundView.layer.borderWidth = Theme.Cell.borderWidth
        roundedBackgroundView.layer.borderColor = Theme.Cell.borderColor.cgColor
        
        self.roundedBackgroundView = roundedBackgroundView
        
        let imageView = ProgressiveImageView(size: .large)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        self.profilePictureImageView = imageView
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90),
            NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
        ])
        
        imageView.loadPicture(picture: viewModel.user.picture)
        
        let nameLabel = UILabel()
        nameLabel.font = Theme.Cell.titleFont
        nameLabel.textColor = Theme.Cell.titleColor
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = viewModel.userName
        nameLabel.textAlignment = .center
        self.view.addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: nameLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: nameLabel, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0),
        ])
        
        let tableView = UITableView(frame: .null, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.roundedBackgroundView.addSubview(tableView)
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .leading, multiplier: 1, constant: 16),
            NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .trailing, multiplier: 1, constant: -16)
        ])
        self.tableView = tableView
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if viewModel.sections[indexPath.section] == .location {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsLocationTableViewCell.reuseIdentifier) as! UserDetailsLocationTableViewCell
            if let location = viewModel.getLocation() {
                cell.setLocation(location: location)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsTextTableViewCell.reuseIdentifier) as! UserDetailsTextTableViewCell
        let title = viewModel.titleForCell(at: indexPath)
        let value = viewModel.valueForCell(at: indexPath)
        cell.setData(title: title, value: value)
        return cell
    }
}
