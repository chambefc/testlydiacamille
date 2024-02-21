//
//  Login.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Login: Decodable {
        var uuid: String?
        var username: String?
        var password: String?
        var salt: String?
        var md5: String?
        var sha1: String?
        var sha256: String?

        // MARK: - SwiftData conformance
        init(
            uuid: String? = nil,
            username: String? = nil,
            password: String? = nil,
            salt: String? = nil,
            md5: String? = nil,
            sha1: String? = nil,
            sha256: String? = nil
        ) {
            self.uuid = uuid
            self.username = username
            self.password = password
            self.salt = salt
            self.md5 = md5
            self.sha1 = sha1
            self.sha256 = sha256
        }

        // MARK: - Decodable conformance
        enum CodingKeys: CodingKey {
            case uuid
            case username
            case password
            case salt
            case md5
            case sha1
            case sha256
        }

        required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.Login.CodingKeys> = try decoder.container(keyedBy: User.Login.CodingKeys.self)
            self.uuid = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.uuid)
            self.username = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.username)
            self.password = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.password)
            self.salt = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.salt)
            self.md5 = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.md5)
            self.sha1 = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.sha1)
            self.sha256 = try container.decodeIfPresent(String.self, forKey: User.Login.CodingKeys.sha256)
        }
    }
    
}
