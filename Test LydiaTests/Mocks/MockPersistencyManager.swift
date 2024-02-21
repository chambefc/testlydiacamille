//
//  MockPersistencyManager.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 21/02/2024.
//

@testable import Test_Lydia

class MockPersistencyManager: PersistencyManagerType {

    enum FlowCase {
        case addUsers
        case getCachedUsers
        case addImageStep
        case deleteAll
        case getCachedImageStep
    }

    private let didCall: (FlowCase) -> Void
    private let users: [User]?

    init(users: [Test_Lydia.User]?, didCall: @escaping (FlowCase) -> Void) {
        self.didCall = didCall
        self.users = users
    }

    func addUsers(users: [Test_Lydia.User]) async {
        didCall(.addUsers)
    }
    
    func getCachedUsers() async -> [Test_Lydia.User] {
        didCall(.getCachedUsers)
        return users ?? []
    }
    
    func addImageStep(step: Test_Lydia.ProgressiveImageView.ImageStep) async {
        didCall(.addImageStep)
    }
    
    func deleteAll() async {
        didCall(.deleteAll)
    }
    
    func getCachedImageStep(path: String) async -> Test_Lydia.ProgressiveImageView.ImageStep? {
        didCall(.getCachedImageStep)
        return nil
    }
}
