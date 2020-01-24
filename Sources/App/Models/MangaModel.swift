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
    
    @Field(key: "cover")
    var coverURL: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    init(){}
    
    init(id: Int? = nil, coverURL: String, title: String, description: String) {
        self.id = id
        self.coverURL = coverURL
        self.title = title
        self.description = title
    }
}
