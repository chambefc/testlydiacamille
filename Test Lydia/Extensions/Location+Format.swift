//
//  Location+Format.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation

extension User.Location {

    // Returns the User's full address formatted as String
    func formattedAddress() -> String {
        var firstElement = ""
        if let streetNumber = self.street?.number { firstElement += String(streetNumber) }
        if let streetName = self.street?.name { firstElement += firstElement.count > 0 ? " " + streetName : streetName }

        var secondElement = ""
        if let postCode = self.postcode { secondElement += postCode }
        if let city = self.city { secondElement += secondElement.count > 0 ? " " + city : city }

        var thirdElement = ""
        if let state = self.state { thirdElement += thirdElement.count > 0 ? " " + state : state }
        if let country = self.country { thirdElement += thirdElement.count > 0 ? " " + country : country }

        return
            (!firstElement.isEmpty ? firstElement + "\n" : firstElement) +
            (!secondElement.isEmpty ? secondElement + "\n" : secondElement) +
            thirdElement
    }

}
