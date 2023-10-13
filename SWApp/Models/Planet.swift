//
//  Planets.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

struct Planet: Decodable, Hashable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [URL]
    let films: [URL]
//    let created: Date
//    let edited: Date
    let url: URL

    static var example = Planet(name: "Test",
                                rotationPeriod: "Test",
                                orbitalPeriod: "Test",
                                diameter: "Test",
                                climate: "Test",
                                gravity: "Test",
                                terrain: "Test",
                                surfaceWater: "Test",
                                population: "Test",
                                residents: [],
                                films: [],
                                url: URL(string: "https://swapi.dev/api/people/1/")!)
}
