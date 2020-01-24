import Fluent
import Vapor

func routes(_ app: Application) throws {
    let index = Index()
    let usersController = UserController()
    let mangaController = Manga()
    try app.register(collection: index)
    try app.register(collection: usersController)
    try app.register(collection: mangaController)
}
