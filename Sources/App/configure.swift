import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    

    app.databases.use(.postgres(
        hostname: Environment.get("POSTGRES_HOSTNAME") ?? "localhost",
        username: Environment.get("POSTGRES_USER") ?? "vapor_username",
        password: Environment.get("POSTGRES_PASSWORD") ?? "vapor_password",
        database: Environment.get("POSTGRES_DB") ?? "vapor_database"
    ), as: .psql)

    app.migrations.add(User.Migration())
    app.migrations.add(Manga.Migration())
    app.migrations.add(UsersManga.Migration())
    
    // register routes
    try routes(app)
}
