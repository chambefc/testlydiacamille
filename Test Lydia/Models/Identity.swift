//
//  Identity.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Identity: Decodable {
        var title: String?
        var first: String?
        var last: String?

        // MARK: - SwiftData conformance
        init(
            title: String? = nil,
            first: String? = nil,
            last: String? = nil
        ) {
            self.title = title
            self.first = first
            self.last = last
        }

        // MARK: - Decodable conformance
        enum CodingKeys: CodingKey {
            case title
            case first
            case last
        }

        required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.Identity.CodingKeys> = try decoder.container(keyedBy: User.Identity.CodingKeys.self)
            self.title = try container.decodeIfPresent(String.self, forKey: User.Identity.CodingKeys.title)
            self.first = try container.decodeIfPresent(String.self, forKey: User.Identity.CodingKeys.first)
            self.last = try container.decodeIfPresent(String.self, forKey: User.Identity.CodingKeys.last)
        }
    }
    
}
