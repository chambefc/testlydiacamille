//
//  Coordinates.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Coordinates: Decodable {
        var latitude: String?
        var longitude: String?

        // MARK: - SwiftData conformance
        init(
            latitude: String? = nil,
            longitude: String? = nil
        ) {
            self.latitude = latitude
            self.longitude = longitude
        }

        // MARK: - Decodable conformance
        enum CodingKeys: CodingKey {
            case latitude
            case longitude
        }

        required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.Coordinates.CodingKeys> = try decoder.container(keyedBy: User.Coordinates.CodingKeys.self)
            self.latitude = try container.decodeIfPresent(String.self, forKey: User.Coordinates.CodingKeys.latitude)
            self.longitude = try container.decodeIfPresent(String.self, forKey: User.Coordinates.CodingKeys.longitude)
        }
    }
    
}
