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
    let created: String
    let edited: String
    let url: URL

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
                                created: "Yesterday",
                                edited: "Today",
                                url: URL(string: "https://swapi.dev/api/people/1/")!)
}
