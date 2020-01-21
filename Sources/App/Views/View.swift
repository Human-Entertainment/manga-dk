//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 20/01/2020.
//

import Plot

struct Views {
    func index() -> HTML {
        HTML(.head(.goodHead()) ,.body(.mangaCard()))
    static func underConstruction() -> HTML {
        let underConstruction = "Manga.dk is currently under construction"
        return HTML(.head(.goodHead(title: underConstruction)),
             .body(.div(.class("construction"),
                        .p("\(underConstruction)"))))
    }
}

extension Node where Context: HTML.BodyContext {
    static func mangaCard() -> Self {
        .div(
            .class("manga"),
            .img(.src("https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx108092-vbL3rf0b23sp.jpg"))
        )
    }
}

extension Node where Context == HTML.HeadContext {
    static func goodHead() -> Self {
        .group([.title("Hello"),.stylesheet("style.css")])
    static func goodHead(title: String) -> Self {
        .group([.title(title),.stylesheet("style.css")])
    }
}
