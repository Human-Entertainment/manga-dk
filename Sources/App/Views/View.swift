//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 20/01/2020.
//

import Plot

struct Views {
    let manga = Manga(coverURL: "hello.jpeg", title: "The order is a rabbit")
    func index() -> HTML {
        HTML(.head(.goodHead(title: "Manga.dk")) ,.body(.mangaCard(manga)))
    }
    
    static func underConstruction() -> HTML {
        let underConstruction = "Manga.dk is currently under construction"
        return HTML(.head(.goodHead(title: underConstruction)),
             .body(.div(.class("construction"),
                        .p("\(underConstruction)"))))
    }
}

extension Node where Context: HTML.BodyContext {
    static func mangaCard(_ manga: Manga) -> Self {
        .div(
            .class("manga-card"),
            .img(.src(manga.coverURL)),
            .p("\(manga.title)")
        )
    }
}

extension Node where Context == HTML.HeadContext {
    static func goodHead(title: String) -> Self {
        .group([.title(title),.stylesheet("style.css")])
    }
}
