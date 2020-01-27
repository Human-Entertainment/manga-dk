//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 23/01/2020.
//

import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersRoutes = routes.grouped("users")
        usersRoutes.get("", use: getUsers)
        let userRoutes = routes.grouped("user")
        userRoutes.post("", use: createUser)
        userRoutes.get(":id", use: getUser)
        userRoutes.get(":id", "collection", use: publicCollection)
        userRoutes.post(":id", "add", use: addManga)
    }
    
    func addManga(req: Request) throws -> EventLoopFuture<[Manga]> {
        guard let userID: User.IDValue = req.parameters.get("id") else { throw Abort(.notFound) }
        guard let bookID: Manga.IDValue = try? req.content.decode(Manga.PurchaseContent.self).id else { throw Abort(.notFound) }
        _ = UsersManga(userID: userID, mangaID: bookID).save(on: req.db)
        return try self.publicCollection(req: req)
    }
    
    func getUsers(req: Request) throws -> EventLoopFuture<[User]> {
        User.query(on: req.db).all()
    }
    
    func createUser(req: Request) throws -> EventLoopFuture<User> {
        try User.Create.validate(req)
        let create = try req.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            name: create.name,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )
        return user.save(on: req.db)
            .map { user }
    }
    
    func getUser(req: Request) throws -> EventLoopFuture<User> {
        let userID: User.IDValue? = req.parameters.get("id")
        return User.find(userID, on: req.db)
          .unwrap(or: Abort(.notFound))
        
    }
    
    func publicCollection(req: Request) throws -> EventLoopFuture<[Manga]> {
        let userID: User.IDValue? = req.parameters.get("id")
        return User
            .find(userID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                try! $0.$books
                        .query(on: req.db)
                        .all()
            }
    }

}

extension User {
    struct Create: Content {
        var name: String
        var email: String
        var password: String
        var confirmPassword: String
    }
}

extension User.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("name", as: String.self, is: !.empty)
        validations.add("email", as: String.self, is: .email)
        validations.add("password", as: String.self, is: .count(8...))
    }
}

enum UserError: Error {
    case noUser
    case notAnID
    case noUserFound
}
