//
//  TimeOrigin+Format.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation

extension User.TimeOrigin {

    // Returns the User's full date of birth information formatted as String
    func dateOfBirthFormatted() -> String {
        var dateOfBirth = ""
        if let stringDate = self.date {

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = formatter.date(from:stringDate)!

            formatter.dateFormat = "dd/MM/yyyy"
            dateOfBirth += formatter.string(from: date)
        }
        if let age = self.age {
            let sentence = String(format: "USER_DETAILS_DATE_OF_BIRTH_AGE_FORMAT".localized(), age)
            dateOfBirth += dateOfBirth.count > 0 ? "\n" + sentence : sentence
        }
        return dateOfBirth
    }

    // Returns the User's full registration information formatted as String
    func registrationFormatted() -> String {
        var registration = ""
        if let stringDate = self.date {

            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = formatter.date(from:stringDate)!

            formatter.dateFormat = "dd/MM/yyyy"
            registration += formatter.string(from: date)
        }
        if let age = self.age {
            let sentence = String(format: "USER_DETAILS_REGISTRATION_FORMAT".localized(), age)
            registration += registration.count > 0 ? "\n" + sentence : sentence
        }
        return registration
    }

}
