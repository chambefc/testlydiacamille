//
//  UserRepository.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 17/02/2024.
//

import Foundation

protocol UserRepositoryType {
    func getUsers(limit: Int, fromStart: Bool) async throws -> [User]
}

/// This class is responsible for fetching and caching the users
final class UserRepository: UserRepositoryType {
    private let networkClient: NetworkClientType
    private let requestBuilder: RequestBuilderType

    init(
        networkClient: NetworkClientType,
        requestBuilder: RequestBuilderType
    ) {
        self.networkClient = networkClient
        self.requestBuilder = requestBuilder
    }

    func getUsers(limit: Int, fromStart: Bool = false) async throws -> [User] {
        if ReachabilityManager.shared.isNetworkReachable == false {
            return await PersistencyManager.shared.getCachedUsers()
        }

        if fromStart {
            await PersistencyManager.shared.deleteAll()
        }

        guard let request = requestBuilder.request(for: UsersEndpoint(limit: limit)) else {
            throw UserRepositoryError.invalidRequest
        }
        let response: User.Response = try await networkClient.executeDecodableRequest(request)
        let users = response.results ?? []
        await PersistencyManager.shared.addUsers(users: users)
        return users
    }
}

private extension UserRepository {
    enum UserRepositoryError: Error {
        case invalidRequest
    }
}
