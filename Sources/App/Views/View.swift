//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 20/01/2020.
//

import Plot

struct Views {
    func index() -> HTML {
        HTML(.body(.mangaCard()))
    }
}

extension Node where Context: HTML.BodyContext {
    static func mangaCard() -> Self {
        return .div(
            .class("manga"),
            .img(.src("https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx108092-vbL3rf0b23sp.jpg"))
        )
    }
}
