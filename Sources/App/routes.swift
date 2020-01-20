import Fluent
import Vapor

func routes(_ app: Application) throws {
    let index = Index()
    try app.register(collection: index)
}
