import Fluent
import Vapor

func routes(_ app: Application) throws {
    let index = Index()
    let mangaController = Manga()
    try app.register(collection: index)
    try app.register(collection: mangaController)
}
