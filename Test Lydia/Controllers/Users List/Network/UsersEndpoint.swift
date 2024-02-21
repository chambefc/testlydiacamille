//
//  UsersEndpoint.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 17/02/2024.
//

import Foundation

/// The endpoint for fetching users
final class UsersEndpoint: Endpoint {
    var method: HTTPMethod = .GET
    var path: String = "/api"
    var parameters: [String: String]?

    init(limit: Int = 10) {
        self.parameters = [
            "results": "\(limit)"
        ]
    }
}
