//
//  IDKey.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {

    @Model
    final class IDKey: Decodable {
        var name: String?
        var value: String?

        // MARK: - SwiftData conformance
        init(
            name: String? = nil,
            value: String? = nil
        ) {
            self.name = name
            self.value = value
        }

        // MARK: - Decodable conformance
        enum CodingKeys: String, CodingKey {
            case name
            case value
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String?.self, forKey: .name)
            self.value = try container.decode(String?.self, forKey: .value)
        }
    }
}

