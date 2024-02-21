//
//  MockReachabilityManager.swift
//  Test LydiaTests
//
//  Created by Camille Chambefort on 20/02/2024.
//

@testable import Test_Lydia

class MockReachabilityManager: ReachabilityManagerType {
    var isNetworkReachable: Bool
    
    init(
        isNetworkReachable: Bool = true
    ) {
        self.isNetworkReachable = isNetworkReachable
    }
}
