//
//  Starship.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

struct Starship: Decodable, Hashable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let maxAtmospheringSpeed: String
    let crew: String
    let passengers: String
    let cargoCapacity: String
    let consumables: String
    let hyperdriveRating: String
    let mglt: String
    let starshipClass: String
    let pilots: [URL]
    let films: [URL]
//    let created: Date
//    let edited: Date
    let url: URL
}
