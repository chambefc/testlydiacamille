//
//  Endpoint.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 17/02/2024.
//

import Foundation

/// Object used by the RequestBuilder to create a new URLRequest
protocol Endpoint {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: String]? { get }
}
