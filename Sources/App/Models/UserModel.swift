//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 23/01/2020.
//

import Fluent
import Vapor
import PostgresKit

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String

    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "userRole")
    var role: UserRoles
    
    @Siblings(through: UsersManga.self, from: \.$user, to: \.$manga)
    var books: [Manga]

    init() { }

    init(id: Int? = nil, name: String, email: String, passwordHash: String, role: UserRoles = .everyone) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.role = role
    }
}

extension User: ModelUser {
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}

struct UserRoles: OptionSet, Codable  {
    init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    let rawValue: UInt64
    
    func encode(to encoder: Encoder) throws {
      try rawValue.encode(to: encoder)
    }
    
    init(from decoder: Decoder) throws {
      rawValue = try .init(from: decoder)
    }
    
    /// This is a given user, used for default Init in User
    static let everyone: Self = []
    /// Anyone with this priv can change a different user
    static let modUser = Self(rawValue: 1 << 1)
    /// This user can edit and add books to the system
    static let mangaUpload = Self(rawValue: 1 << 2)
    
    /// Has all the rights, you shouldn't check on this, only make a user super admin
    static let superAdmin = Self(rawValue: .max)
}
