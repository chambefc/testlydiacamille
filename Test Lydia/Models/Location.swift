//
//  Location.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    
    @Model
    final class Location: Decodable {
        @Relationship var street: Street?
        var city: String?
        var state: String?
        var country: String?
        var postcode: String?
        @Relationship var coordinates: Coordinates?
        @Relationship var timezone: Timezone?

        // MARK: - SwiftData conformance
        init(
            street: Street? = nil,
            city: String? = nil,
            state: String? = nil,
            country: String? = nil,
            postcode: String? = nil,
            coordinates: Coordinates? = nil,
            timezone: Timezone? = nil
        ) {
            self.street = street
            self.city = city
            self.state = state
            self.country = country
            self.postcode = postcode
            self.coordinates = coordinates
            self.timezone = timezone
        }
        // MARK: - Decodable conformance
        enum CodingKeys: CodingKey {
            case street
            case city
            case state
            case country
            case postcode
            case coordinates
            case timezone
        }

        required init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<User.Location.CodingKeys> = try decoder.container(keyedBy: User.Location.CodingKeys.self)
            self.street = try container.decodeIfPresent(User.Street.self, forKey: User.Location.CodingKeys.street)
            self.city = try container.decodeIfPresent(String.self, forKey: User.Location.CodingKeys.city)
            self.state = try container.decodeIfPresent(String.self, forKey: User.Location.CodingKeys.state)
            self.country = try container.decodeIfPresent(String.self, forKey: User.Location.CodingKeys.country)
            self.coordinates = try container.decodeIfPresent(User.Coordinates.self, forKey: User.Location.CodingKeys.coordinates)
            self.timezone = try container.decodeIfPresent(User.Timezone.self, forKey: User.Location.CodingKeys.timezone)
            // Catches any error if postcode is not in String format, tries in Int format, then leaves the attribute to nil if everything fails
            do {
                self.postcode = try container.decodeIfPresent(String.self, forKey: User.Location.CodingKeys.postcode)
            } catch {
                if let numeric = try? container.decode(Int.self, forKey: User.Location.CodingKeys.postcode) {
                    self.postcode = String(numeric)
                }
            }
        }
    }
    
}
