//
//  UserDetailsViewModel+Sections.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation

extension UserDetailsViewModel {
    // Represents one of the tableView's sections
    enum Section {
        case registration
        case origin
        case details
        case location
        case timezone
        case login
        case id

        // Returns the section's title to be displayed in the TableView (Header for Section)
        var title: String? {
            switch self {
            case .registration:
                return "USER_DETAILS_SECTION_REGISTRATION".localized()
            case .origin:
                return "USER_DETAILS_SECTION_ORIGINS".localized()
            case .details:
                return "USER_DETAILS_SECTION_DETAILS".localized()
            case .location:
                return "USER_DETAILS_SECTION_ADDRESS".localized()
            case .timezone:
                return "USER_DETAILS_SECTION_TIMEZONE".localized()
            case .login:
                return "USER_DETAILS_SECTION_LOGIN".localized()
            case .id:
                return "USER_DETAILS_SECTION_ID".localized()
            }
        }

        // Returns an array of fields to be displayed in the Section
        var fields: [Field] {
            switch self {
            case .registration:
                return [.registration]
            case .origin:
                return [.gender, .nationality, .dateOfBirth]
            case .details:
                return [.email, .phone, .cell]
            case .timezone:
                return [.offset, .description]
            case .login:
                return [.uuid, .username, .password, .salt, .md5, .sha1, .sha256]
            case .id:
                return [.idName, .idValue]
            default:
                return []
            }
        }

        // All existing fields from every section
        enum Field: String {
            case registration
            case gender
            case nationality
            case dateOfBirth
            case email
            case phone
            case cell
            case offset
            case description
            case uuid
            case username
            case password
            case salt
            case md5
            case sha1
            case sha256
            case idName
            case idValue

            // The field's key
            var title: String {
                switch self {
                case .registration: return "USER_DETAILS_REGISTRATION".localized()
                case .gender:       return "USER_DETAILS_ORIGIN_GENDER".localized()
                case .nationality:  return "USER_DETAILS_ORIGIN_NATIONALITY".localized()
                case .dateOfBirth:  return "USER_DETAILS_ORIGIN_DATE_OF_BIRTH".localized()
                case .email:        return "USER_DETAILS_DETAILS_EMAIL".localized()
                case .phone:        return "USER_DETAILS_DETAILS_PHONE".localized()
                case .cell:         return "USER_DETAILS_DETAILS_CELL".localized()
                case .offset:       return "USER_DETAILS_TIMEZONE_OFFSET".localized()
                case .description:  return "USER_DETAILS_TIMEZONE_DESCRIPTION".localized()
                case .uuid:         return "USER_DETAILS_LOGIN_UUID".localized()
                case .username:     return "USER_DETAILS_LOGIN_USERNAME".localized()
                case .password:     return "USER_DETAILS_LOGIN_PASSWORD".localized()
                case .salt:         return "USER_DETAILS_LOGIN_SALT".localized()
                case .md5:          return "USER_DETAILS_LOGIN_MD5".localized()
                case .sha1:         return "USER_DETAILS_LOGIN_SHA1".localized()
                case .sha256:       return "USER_DETAILS_LOGIN_SHA256".localized()
                case .idName:       return "USER_DETAILS_ID_NAME".localized()
                case .idValue:      return "USER_DETAILS_ID_VALUE".localized()
                }
            }
        }
    }
}
