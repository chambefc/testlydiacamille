//
//  LydiaTestCase.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 20/02/2024.
//

import XCTest
@testable import Test_Lydia

class LydiaTestCase: XCTestCase {
    
    override class func setUp() {
        ReachabilityManager.shared = MockReachabilityManager()
    }

    override class func tearDown() {
        Task {
            await PersistencyManager.shared.deleteAll()
        }

        super.tearDown()
    }
}
