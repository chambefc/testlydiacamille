//
//  Picture.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Picture: Decodable {
        var large: String?
        var medium: String?
        var thumbnail: String?

        // MARK: - SwiftData conformance
        init(
            large: String? = nil,
            medium: String? = nil,
            thumbnail: String? = nil
        ) {
            self.large = large
            self.medium = medium
            self.thumbnail = thumbnail
        }

        // MARK: - Decodable conformance
        enum CodingKeys: String, CodingKey {
            case large
            case medium
            case thumbnail
        }

        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.large = try container.decode(String?.self, forKey: .large)
            self.medium = try container.decode(String?.self, forKey: .medium)
            self.thumbnail = try container.decode(String?.self, forKey: .thumbnail)
        }
    }
}
