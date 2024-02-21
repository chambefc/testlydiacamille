//
//  TimeOrigin.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {

    @Model
    final class TimeOrigin: Decodable {
        var date: String?
        var age: Int?
        
        // MARK: - SwiftData conformance
        init(date: String? = nil, age: Int? = nil) {
            self.date = date
            self.age = age
        }

        // MARK: - Decodable conformance
        enum CodingKeys: CodingKey {
            case date
            case age
        }

        required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.TimeOrigin.CodingKeys> = try decoder.container(keyedBy: User.TimeOrigin.CodingKeys.self)
            self.date = try container.decodeIfPresent(String.self, forKey: User.TimeOrigin.CodingKeys.date)
            self.age = try container.decodeIfPresent(Int.self, forKey: User.TimeOrigin.CodingKeys.age)
        }
    }

}
