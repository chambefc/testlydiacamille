//
//  Street.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Street: Decodable {
        var number: Int?
        var name: String?

        // MARK: - SwiftData conformance
        init(
            number: Int? = nil,
            name: String? = nil
        ) {
            self.number = number
            self.name = name
        }

        // MARK: - Decodable conformance
        enum CodingKeys: CodingKey {
            case number
            case name
        }

        required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.Street.CodingKeys> = try decoder.container(keyedBy: User.Street.CodingKeys.self)
            self.number = try container.decodeIfPresent(Int.self, forKey: User.Street.CodingKeys.number)
            self.name = try container.decodeIfPresent(String.self, forKey: User.Street.CodingKeys.name)
        }
    }
    
}
