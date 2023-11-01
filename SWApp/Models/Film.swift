//
//  Film.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

struct Film: Decodable, Hashable {
    let episodeId: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [URL]
    let planets: [URL]
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let url: URL
    let created: String
    let edited: String

    var createdDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        return dateFormatter.date(from: created)
    }

    var editedDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        return dateFormatter.date(from: edited)
    }

    static let example = Film(episodeId: 0,
                              title: "Test",
                              openingCrawl: "Test Test Test Test",
                              director: "Tester Testerson",
                              producer: "Producer",
                              releaseDate: "01-01-2000",
                              characters: [],
                              planets: [],
                              species: [],
                              starships: [],
                              vehicles: [],
                              url: URL(string: "https://swapi.dev/api/films/1/")!,
                              created: "Yesterday",
                              edited: "Today")
}
