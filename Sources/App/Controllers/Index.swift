import Vapor
import Plot

struct Index: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
        routes.get("", use: index)
	}

    func index(req: Request) throws -> EventLoopFuture<HTML> {
        Views.underConstruction.encodeResponse(for: req)
	}
    
}
