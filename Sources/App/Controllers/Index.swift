import Vapor
import Plot

struct Index: RouteCollection {
	func boot(routes: RoutesBuilder) throws {

	}

    func index(req: Request) throws -> EventLoopFuture<HTML> {
        return Views().index().encodeResponse(for: req)
	}
}
