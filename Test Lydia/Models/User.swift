//
//  User.swift
//  Test Lydia
//
//  Created by Camille Chambefort on 18/02/2024.
//

import SwiftData

extension User {
    /// Model used to serialize User HTTP GET call
    class Response: Decodable {
        var results: [User]?
    }
}

@Model
final class User: Decodable, Hashable {

    var gender: String?
    @Relationship var name: Identity?
    @Relationship var location: Location?
    var email: String?
    @Relationship var login: Login?
    @Relationship var dateOfBirth: TimeOrigin?
    @Relationship var registerDate: TimeOrigin?
    var phone: String?
    var cell: String?
    @Relationship var idKey: IDKey?
    @Relationship var picture: Picture?
    var nat: String?

    // MARK: - SwiftData conformance
    init(
        gender: String? = nil,
        name: Identity? = nil,
        location: Location? = nil,
        email: String? = nil,
        login: Login? = nil,
        dateOfBirth: TimeOrigin? = nil,
        registerDate: TimeOrigin? = nil,
        phone: String? = nil,
        cell: String? = nil,
        idKey: IDKey? = nil,
        picture: Picture? = nil,
        nat: String? = nil
    ) {
        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.login = login
        self.dateOfBirth = dateOfBirth
        self.registerDate = registerDate
        self.phone = phone
        self.cell = cell
        self.idKey = idKey
        self.picture = picture
        self.nat = nat
    }

    // MARK: - Decodable conformance
    enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case email
        case login
        case dateOfBirth = "dob"
        case registerDate = "registered"
        case phone
        case cell
        case idKey = "id"
        case picture
        case nat
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
        self.name = try container.decodeIfPresent(User.Identity.self, forKey: .name)
        self.location = try container.decodeIfPresent(User.Location.self, forKey: .location)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.login = try container.decodeIfPresent(User.Login.self, forKey: .login)
        self.dateOfBirth = try container.decodeIfPresent(User.TimeOrigin.self, forKey: .dateOfBirth)
        self.registerDate = try container.decodeIfPresent(User.TimeOrigin.self, forKey: .registerDate)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.cell = try container.decodeIfPresent(String.self, forKey: .cell)
        self.idKey = try container.decodeIfPresent(User.IDKey.self, forKey: .idKey)
        self.picture = try container.decodeIfPresent(User.Picture.self, forKey: .picture)
        self.nat = try container.decodeIfPresent(String.self, forKey: .nat)
    }

    // MARK: - Comparable compliance
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    // MARK: - Hashable compliance
    func hash(into hasher: inout Hasher) {
        hasher.combine(name?.title)
        hasher.combine(name?.first)
        hasher.combine(name?.last)
        hasher.combine(dateOfBirth?.date)
        hasher.combine(registerDate?.date)
    }
}
