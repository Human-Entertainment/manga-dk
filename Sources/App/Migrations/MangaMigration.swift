//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 23/01/2020.
//

import Fluent
import Vapor

extension Manga {
    struct Migration: Fluent.Migration {
        let name = "manga"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("manga")
                .field("id", .int, .identifier(auto: true))
                .field("title", .string, .required)
                .field("coverURL", .string, .required)
                .field("description", .string, .required)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("manga").delete()
        }
    }
}
