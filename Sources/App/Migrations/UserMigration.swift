import Fluent
import Vapor

extension User {
    struct Migration: Fluent.Migration {
        let name = "user"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("users")
                .field("id", .int, .identifier(auto: true))
                .field("name", .string, .required)
                .field("email", .string, .required)
                .field("password_hash", .string, .required)
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("users").delete()
        }
    }
}
