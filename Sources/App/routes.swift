import Fluent
import Vapor

func routes(_ app: Application) throws {
    let index = Index()
    
    app.get("", use: index.index)

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    let todoController = TodoController()
    app.get("todos", use: todoController.index)
    app.post("todos", use: todoController.create)
    app.delete("todos", ":todoID", use: todoController.delete)
}
