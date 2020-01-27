//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 27/01/2020.
//

import Fluent

final class UsersManga: Model {
    static let schema = "users-manga"
    
    @ID(key: "id")
    var id: Int?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "manga_id")
    var manga: Manga
    
    init() {}
    
    init(userID: Int, mangaID: Int) {
        self.$manga.id = mangaID
        self.$user.id = userID
    }
}

extension UsersManga: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UsersManga.schema)
            .field("id", .int, .identifier(auto: true))
            .field("user_id", .int, .required)
            .field("manga_id", .int, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema(UsersManga.schema).delete()
    }
}
