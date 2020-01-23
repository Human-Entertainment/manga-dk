import Vapor
import Plot

struct Index: RouteCollection {
	func boot(routes: RoutesBuilder) throws {
        routes.get("", use: construction)
        routes.get("index.html", use: index)
	}

    func construction(req: Request) throws -> EventLoopFuture<HTML> {
        // TODO: Make this into a fluent model to make it more dynamic
        let mwr = Partners(img: "https://mangaworthreading.co/wp-content/uploads/2019/09/Header-Main@2x.png", link: "https://mangaworthreading.co/")
        let sif = Partners(img: "https://i0.wp.com/switchindiefix.com/wp-content/uploads/2018/09/cropped-logo-text-red.png", link: "http://switchindiefix.com")
        return Views.underConstruction(/*sif, */mwr).encodeResponse(for: req)
	}
    
    func index(req: Request) throws -> EventLoopFuture<HTML> {
        Views.index().encodeResponse(for: req)
    }
    
}
