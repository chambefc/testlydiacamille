//
//  ReachabilityManager.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import Foundation
import Network

protocol ReachabilityManagerType {
    var isNetworkReachable: Bool { get }
}

/// Checks the network's reachability
final class ReachabilityManager: ReachabilityManagerType {

    // Singleton
    static var shared: ReachabilityManagerType = ReachabilityManager()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NWPathMonitor")
    private(set) var isNetworkReachable: Bool = false

    // Prevents instantiation other than the singleton's
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isNetworkReachable = path.status == .satisfied
            }
        }

        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
