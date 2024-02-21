//
//  MockUserRepository.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 20/02/2024.
//

@testable import Test_Lydia

extension MockUserRepository {
    enum TestCase {
        case success(users: [User])
        case failure(error: Error)
    }
}

class MockUserRepository: UserRepositoryType {
    let testCase: TestCase
    let wasCalled: (() -> Void)?

    init(testCase: TestCase, wasCalled: (() -> Void)? = nil) {
        self.testCase = testCase
        self.wasCalled = wasCalled
    }

    func getUsers(
        limit: Int,
        fromStart: Bool
    ) async throws -> [Test_Lydia.User] {
        wasCalled?()
        switch testCase {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
}
