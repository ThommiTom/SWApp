//
//  Film.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

struct Film {
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
    let created: Date
    let edited: Date
}
