//
//  UserDetailsViewModel.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation

/// UserDetailsViewController's ViewModel
final class UserDetailsViewModel {
    
    let user: User

    // The list of sections to be displayed to the user
    let sections: [Section] = [.registration, .origin, .details, .location, .timezone, .login, .id]
    
    var userName: String? {
        return user.name?.formattedName()
    }
    
    init(user: User) {
        self.user = user
    }
    
    // Returns the title for the cell at indexPath to the ViewController
    func titleForCell(at indexPath: IndexPath) -> String {
        let section = self.sections[indexPath.section]
        let field = section.fields[indexPath.row]
        return field.title
    }
    
    // Returns the value for the cell at indexPath to the ViewController
    func valueForCell(at indexPath: IndexPath) -> String? {
        let section = self.sections[indexPath.section]
        let field = section.fields[indexPath.row]
        switch field {
        case .registration: return user.registerDate?.registrationFormatted()
        case .gender:       return user.gender
        case .nationality:  return user.nat
        case .dateOfBirth:  return user.dateOfBirth?.dateOfBirthFormatted()
        case .email:        return user.email
        case .phone:        return user.phone
        case .cell:         return user.cell
        case .offset:       return user.location?.timezone?.offset
        case .description:  return user.location?.timezone?.descriptionString
        case .uuid:         return user.login?.uuid
        case .username:     return user.login?.username
        case .password:     return user.login?.password
        case .salt:         return user.login?.salt
        case .md5:          return user.login?.md5
        case .sha1:         return user.login?.sha1
        case .sha256:       return user.login?.sha256
        case .idName:       return user.idKey?.name
        case .idValue:      return user.idKey?.value
        }
    }
    
    // Returns the section at indexPath to the ViewController
    func section(for indexPath: IndexPath) -> Section {
        return self.sections[indexPath.section]
    }
    
    // Returns the number of cells for a given section to the ViewController
    func numberOfCells(for section: Int) -> Int {
        let section = self.sections[section]
        if section == .location {
            return 1
        }
        return section.fields.count
    }
    
    // Returns the user's location information
    func getLocation() -> User.Location? {
        return user.location
    }
    
}
