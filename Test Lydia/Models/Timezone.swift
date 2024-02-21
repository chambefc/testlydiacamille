//
//  Timezone.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Timezone: Decodable {
        var offset: String?
        var descriptionString: String?

        // MARK: - SwiftData conformance
        init(
            offset: String? = nil,
            descriptionString: String? = nil
        ) {
            self.offset = offset
            self.descriptionString = descriptionString
        }

        // MARK: - Decodable conformance
        enum CodingKeys: String, CodingKey {
            case offset
            case descriptionString = "description"
        }
    
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.offset = try container.decode(String?.self, forKey: .offset)
            self.descriptionString = try container.decode(String?.self, forKey: .descriptionString)
        }
    }

}
