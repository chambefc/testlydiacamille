//
//  UserListViewModelTests.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 20/02/2024.
//

import Foundation
import XCTest
@testable import Test_Lydia

class UserListViewModelTests: LydiaTestCase {

    func test_WhenViewDidLoadIsCalled_AndReachabilityIsPassing_ThenDataIsFetchedSuccessfully() async {

        // Given
        let users = [
            User(name: .init(
                first: "Johnny",
                last: "Halliday")
            ),
            User(name: .init(
                first: "Véronique",
                last: "Sanson")
            )
        ]
        await PersistencyManager.shared.addUsers(users: users)

        let repositoryCallExpectation = expectation(description: "UserRepository was called")
        let repository = MockUserRepository(
            testCase: .success(users: users)) {
                repositoryCallExpectation.fulfill()
            }
        let sut = UserListViewModel(
            repository: repository
        )

        // When
        await sut.viewDidLoad()

        // Then
        await fulfillment(of: [repositoryCallExpectation], timeout: 10)
        XCTAssertEqual(sut.users, users)
    }

    func test_WhenRepositoryFails_ThenErrorIsDisplayed() async {

        // Given
        let repositoryCallExpectation = expectation(description: "UserRepository was called")
        let repository = MockUserRepository(
            testCase: .failure(error: MockError.testError)) {
                repositoryCallExpectation.fulfill()
            }
        let sut = UserListViewModel(
            repository: repository
        )

        // When
        await sut.viewDidLoad()

        // Then
        await fulfillment(of: [repositoryCallExpectation], timeout: 10)
        XCTAssertNotNil(sut.error)
    }
}

private enum MockError: Error {
    case testError
}
