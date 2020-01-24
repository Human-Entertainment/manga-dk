//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 23/01/2020.
//

import Vapor

extension Manga: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let mangaCollection = routes.grouped("manga")
        mangaCollection.post("new", use: createManga)
    }
    
    func createManga(req: Request) throws -> EventLoopFuture<Manga> {
        let manga = try req.content.decode(Manga.self)
        return manga.create(on: req.db).map{ manga }
    }
}
