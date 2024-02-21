//
//  String+Localized.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation

/// Allows to easily localize a string Key like so: "KEY".localized()
extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
}
