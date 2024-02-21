//
//  CommonTests.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 18/02/2024.
//

import XCTest
@testable import Test_Lydia

class CommonTests: LydiaTestCase {

    func testLocalizedString() throws {
        let expected = "Localized String"
        XCTAssertEqual("TEST".localized(), expected)
    }
    
    func testUserNameFormatter() throws {
        let expected = "Mrs Julie Scavino"
        let identity = User.Identity(
            title: "Mrs",
            first: "Julie",
            last: "Scavino"
        )
        XCTAssertEqual(identity.formattedName(), expected)
    }
    
    func testUserAddressFormatter() async throws {
        let firstExpected = "15 Avenue du Groupe Morgan\n06700 St Laurent du Var\nFrance"
        let street = User.Street(number: 15, name: "Avenue du Groupe Morgan")
        let firstLocation = User.Location(
            street: street,
            city: "St Laurent du Var",
            country: "France",
            postcode: "06700"
            )
        let firstUser = User(location: firstLocation)
        await PersistencyManager.shared.addUsers(users: [firstUser])
        XCTAssertEqual(firstLocation.formattedAddress(), firstExpected)
        
        let secondExpected = "2021 Snowden Ave\n90815 Long Beach\nCA USA"
        let secondLocation = User.Location(
            street: User.Street(number: 2021, name: "Snowden Ave"),
            city: "Long Beach",
            state: "CA",
            country: "USA",
            postcode: "90815"
        )
        let secondUser = User(location: secondLocation)
        await PersistencyManager.shared.addUsers(users: [secondUser])
        XCTAssertEqual(secondLocation.formattedAddress(), secondExpected)
        
        let thirdExpected = "Boulevard du Midi\nFrance"
        let thirdLocation = User.Location(
            street: User.Street(number: nil, name: "Boulevard du Midi"),
            country: "France"
        )
        let thirdUser = User(location: thirdLocation)
        await PersistencyManager.shared.addUsers(users: [thirdUser])
        XCTAssertEqual(thirdLocation.formattedAddress(), thirdExpected)
    }
    
    func testUserDateOfBirthFormatter() throws {
        let expected = "19/08/1966\n(38 years old)"
        let timeOrigin = User.TimeOrigin(date: "1966-08-19T01:56:28.926Z", age: 38)
        XCTAssertEqual(expected, timeOrigin.dateOfBirthFormatted())
    }
    
    func testUserRegistrationFormatter() throws {
        let expected = "19/08/1966\n(38 years ago)"
        let timeOrigin = User.TimeOrigin(date: "1966-08-19T01:56:28.926Z", age: 38)
        XCTAssertEqual(expected, timeOrigin.registrationFormatted())
    }

}
