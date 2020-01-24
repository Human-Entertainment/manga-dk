//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 23/01/2020.
//

import Fluent
import Vapor

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

    init() { }

    init(id: Int? = nil, name: String, email: String, passwordHash: String) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
    }
}

extension User: ModelUser {
    static let usernameKey = \User.$email
    static let passwordHashKey = \User.$passwordHash

    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.passwordHash)
    }
}
