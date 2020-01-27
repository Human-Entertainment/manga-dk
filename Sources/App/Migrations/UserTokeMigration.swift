//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 27/01/2020.
//

import Fluent

extension UserToken {
    struct Migration: Fluent.Migration {
        let name = UserToken.schema
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user_tokens")
                .field("id", .int, .identifier(auto: true))
                .field("value", .string, .required)
                .field("user_id", .int, .required, .references("users", "id"))
                .unique(on: "value")
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user_tokens").delete()
        }
    }
}
