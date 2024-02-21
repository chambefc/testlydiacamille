//
//  UITableViewCell+ReuseIdentifier.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 20/02/2024.
//

import UIKit

// Provides a reuseIdentifier specific to the cell's class name
extension UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
}
