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
    let MGLT: String
    let starshipClass: String
    let pilots: [URL]
    let films: [URL]
    let created: String
    let edited: String
    let url: URL

    static var example = Starship(name: "Test",
                                  model: "Test",
                                  manufacturer: "Test",
                                  costInCredits: "Test",
                                  length: "Test",
                                  maxAtmospheringSpeed: "Test",
                                  crew: "Test",
                                  passengers: "Test",
                                  cargoCapacity: "Test",
                                  consumables: "Test",
                                  hyperdriveRating: "Test",
                                  MGLT: "Test",
                                  starshipClass: "Test",
                                  pilots: [],
                                  films: [],
                                  created: "Yesterday",
                                  edited: "Today",
                                  url: URL(string: "https://swapi.dev/api/people/1/")!)
}
