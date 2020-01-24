import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    

    app.databases.use(.postgres(
        hostname: Environment.get("POSTGRES_HOSTNAME") ?? "localhost",
        username: Environment.get("POSTGRES_USER") ?? "vapor",
        password: Environment.get("POSTGRES_PASSWORD") ?? "vapor",
        database: Environment.get("POSTGRES_DB") ?? "vapor"
    ), as: .psql)

    app.migrations.add(User.Migration())
    app.migrations.add(Manga.Migration())
    
    // register routes
    try routes(app)
}
