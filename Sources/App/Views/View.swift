//
//  File.swift
//  
//
//  Created by Bastian Inuk Christensen on 20/01/2020.
//

import Plot
import Foundation



struct Views {
    private static var year: Int {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.year, from: date)
    }
    // TODO: Make manga conform to fluent, to make this more dynamic
    //static let manga = Manga(coverURL: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/nx5081-4RLo87fu8TsC.jpg", title: "Bakemonogatari", description: "Araragi gets stabled")
    static func index(mangas: [Manga]) -> HTML {
        HTML(.head(.goodHead(title: "Manga.dk")) ,.body(.forEach(mangas, { manga in
            .mangaCard(manga)
        }),.mangaFooter(year: year)))
    }
    
    static func underConstruction(_ partners: Partners...) -> HTML {
        let underConstruction = "Manga.dk is currently under construction"
        return HTML(.head(.goodHead(title: underConstruction)),
             .body(.div(.class("construction"),
                        .p("\(underConstruction)", .br(),.br(),
                           "Consider checking our partners:", .br(),.br(),
                           .forEach(partners){ $0.toHTML() }, .br(),.br(),
                           "We also have a ", .a(.href("https://discord.gg/CxPyCCJ"),.target(.blank), "Discord"),
                           .mangaFooter(year: year)
                        )
                    )
            )
        )
    }
}

struct Partners {
    let img: String
    let link: String
    
    func toHTML() -> Node<HTML.BodyContext> {
        .a(.href(link), .target(.blank),
           .img(.class("partners"),.src(img)))
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
    static func mangaFooter(year: Int = 2020) -> Self {
        .footer(.p("Manga.dk is © Inuk Entertainment 2020",.if(year != 2020 && year > 2020,
                    "-\(year)"
                    )))
    }
}

extension Node where Context == HTML.HeadContext {
    static func goodHead(title: String) -> Self {
        .group([.title(title),.stylesheet("/style.css"),.stylesheet("/font/font.css")])
    }
}
