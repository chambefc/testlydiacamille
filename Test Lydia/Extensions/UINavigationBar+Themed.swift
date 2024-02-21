//
//  UINavigationBar+Themed.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import UIKit

/// Sets the app's theme on a UINavigationBar instance
extension UINavigationBar {
    
    func setThemedAppearance() {
        self.prefersLargeTitles = true
        self.largeTitleTextAttributes = [
            .foregroundColor: Theme.Navigation.titleColor,
            .font: Theme.Navigation.largeTitleFont
        ]
        self.titleTextAttributes = [
            .foregroundColor: Theme.Navigation.titleColor,
            .font: Theme.Navigation.smallTitleFont
        ]
    }
    
}
