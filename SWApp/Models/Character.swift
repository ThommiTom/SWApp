//
//  people.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

struct Character: Decodable, Hashable {
    let name: String
    let birthYear: String
    let homeworld: URL
    let gender: String
    let eyeColor: String
    let hairColor: String
    let skinColor: String
    let height: String
    let mass: String
    let films: [URL]
    let species: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let url: URL
//    let created: Date
//    let edited: Date
}
