//
//  NetworkClient.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 17/02/2024.
//

import Foundation

protocol NetworkClientType {
    func executeDataRequest(_ request: URLRequest) async throws -> Data
    func executeDecodableRequest<T: Decodable>(_ request: URLRequest) async throws -> T
}

enum NetworkError: Error {
    case unknownError
    case serverError(Error)
}

/// Handles the execution of an HTTP Requests
final class NetworkClient: NetworkClientType {

    private let session: URLSession

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        self.session = URLSession(configuration: configuration)
    }

    func executeDataRequest(
        _ request: URLRequest
    ) async throws -> Data {
        do {
            let (data, _) = try await session.data(for: request)
            return data
        } catch {
            #if DEBUG
            print(error)
            #endif

            throw NetworkError.unknownError
        }
    }

    func executeDecodableRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, _) = try await session.data(for: request)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            #if DEBUG
            print(error)
            #endif

            throw NetworkError.unknownError
        }
    }
}
