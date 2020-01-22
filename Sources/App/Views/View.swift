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
    
    private struct Partners {
        let img: String
        let link: String
        
        func toHTML() -> Node<HTML.BodyContext> {
            .a(.href(link), .target(.blank),
               .img(.class("partners"),.src(img)))
        }
    }
    
    static var underConstruction: HTML {
        let mwr = Partners(img: "https://mangaworthreading.co/wp-content/uploads/2019/09/Header-Main@2x.png", link: "https://mangaworthreading.co/")
        let sif = Partners(img: "https://i0.wp.com/switchindiefix.com/wp-content/uploads/2018/09/cropped-logo-text-red.png", link: "http://switchindiefix.com")
        let partners = [//sif,
                        mwr]
        let underConstruction = "Manga.dk is currently under construction"
        return HTML(.head(.goodHead(title: underConstruction)),
             .body(.div(.class("construction"),
                        .p("\(underConstruction)",.br(),.br(),
                           "Consider checking our partners:",.br(),.br(),
                           .forEach(partners){ $0.toHTML() },.br(),.br(),
                           "We also have a ",.a(.href("https://discord.gg/CxPyCCJ"),.target(.blank), "Discord")
                        )
                    )
            )
        )
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
        .group([.title(title),.stylesheet("/style.css"),.stylesheet("/font/font.css")])
    }
}
