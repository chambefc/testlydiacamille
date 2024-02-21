//
//  Identity+Format.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation

extension User.Identity {

    // Returns the User's full name formatted as String
    func formattedName() -> String {
        var userName = ""
        if let title = self.title { userName += title }
        if let first = self.first { userName += userName.count > 0 ? " " + first : first }
        if let last = self.last { userName += userName.count > 0 ? " " + last : last }
        return userName
    }
    
}
