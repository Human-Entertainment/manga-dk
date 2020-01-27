//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 21/01/2020.
//

import Fluent
import Vapor

final class Manga: Model, Content {
    static var schema = "manga"
    
    @ID(key: "id")
    var id: Int?
    
    @Field(key: "coverURL")
    var coverURL: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Siblings(through: UsersManga.self, from: \.$manga, to: \.$user)
    var owners: [User]
    
    init() { }
    
    init(id: Int? = nil, coverURL: String, title: String, description: String) {
        self.id = id
        self.coverURL = coverURL
        self.title = title
        self.description = title
    }
}

extension Manga {
    struct PurchaseContent: Content {
        let id: Int
    }
}
