//
//  UserRepositoryTests.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 21/02/2024.
//

import XCTest
@testable import Test_Lydia

class UserRepositoryTests: LydiaTestCase {

    func test_WhenReachabilityIsNotPassing_ThenRepositoryIsNotCalled() async {

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

        let expectation = expectation(description: "Did call PersistencyManager")

        ReachabilityManager.shared = MockReachabilityManager(isNetworkReachable: false)
        PersistencyManager.shared = MockPersistencyManager(users: users, didCall: { flowCase in
            if flowCase == .getCachedUsers {
                expectation.fulfill()
            }
        })

        let sut = UserRepository(
            networkClient: NetworkClient(),
            requestBuilder: RequestBuilder()
        )

        // When
        let fetched = try? await sut.getUsers(limit: 10)

        // Then
        XCTAssertEqual(fetched, users)
        await fulfillment(of: [expectation], timeout: 10)
    }
}
