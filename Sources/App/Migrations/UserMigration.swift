import Fluent
import Vapor
import SQLKit

extension User {
    struct Migration: Fluent.Migration {
        let name = "users"
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema(name)
                .field("id", .int, .identifier(auto: true))
                .field("name", .string, .required)
                .field("email", .string, .required)
                .field("password_hash", .string, .required)
                .field("userRole", .uint64, .required )
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema(name).delete()
        }
    }
}
