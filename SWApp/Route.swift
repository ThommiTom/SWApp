//
//  Route.swift
//  SWApp
//
//  Created by Thomas Schatton on 17.11.23.
//

import SwiftUI

enum Route: Destination {
    case character(Character)
    case film(Film)
    case planet(Planet)
    case starship(Starship)
    case vehicle(Vehicle)

    @ViewBuilder var body: some View {
        switch self {
        case .character(let character): CharacterDetailView(character: character)
        case .film(let film): FilmDetailView(film: film)
        case .planet(let planet): PlanetDetailView(planet: planet)
        case .starship(let starship): StarshipDetailView(starship: starship)
        case .vehicle(let vehicle): VehicleDetailView(vehicle: vehicle)
        }
    }
}
