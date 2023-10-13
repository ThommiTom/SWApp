//
//  FilmDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct FilmDetailView: View {
    @StateObject var filmDetailHandler: FilmDetailHandler

    init(film: Film) {
        // TODO: Caching would be smart to prevent data fetching every time the parent initializes this viewmodel
        _filmDetailHandler = StateObject(wrappedValue: FilmDetailHandler(film: film))
    }

    var body: some View {
        List {
            FilmLabel(film: filmDetailHandler.film)

            Section("Opening Crawl") {
                Text(filmDetailHandler.film.openingCrawl)
            }

            Section("Featured Characters") {
                characterLabel
            }

            Section("Featured Planets") {
                planetLabel
            }

            Section("Featured Starships") {
                starshipLabel
            }

            Section("Featured Vehicles") {
                vehicleLabel
            }
        }
        .navigationTitle("Movie Details")
        .navigationDestination(for: Character.self) { character in
            CharacterDetailView(character: character)
        }
        .navigationDestination(for: Planet.self) { planet in
            PlanetDetailView(planet: planet)
        }
        .navigationDestination(for: Starship.self) { starship in
            StarshipDetailView(starship: starship)
        }
        .navigationDestination(for: Vehicle.self) { vehicle in
            VehicleDetailView(vehicle: vehicle)
        }
    }

    var characterLabel: some View {
        Group {
            if filmDetailHandler.fetchingCharacters {
                ActivityIndicator(title: "Fetching Characters",
                                  hintMessage: "Patience, young padawan...")
            } else {
                ForEach(filmDetailHandler.characters, id: \.self) { character in
                    VStack(alignment: .leading) {
                        NavigationLink(value: character) {
                            Text(character.name)
                        }
                    }
                }
            }
        }
    }

    var planetLabel: some View {
        Group {
            if filmDetailHandler.fetchingPlanets {
                ActivityIndicator(title: "Fetching Planets",
                                  hintMessage: "May the Force be with you.")
            } else {
                ForEach(filmDetailHandler.planets, id: \.self) { planet in
                    VStack(alignment: .leading) {
                        NavigationLink(value: planet) {
                            Text(planet.name)
                        }
                    }
                }
            }
        }
    }

    var starshipLabel: some View {
        Group {
            if filmDetailHandler.fetchingStarships {
                ActivityIndicator(title: "Fetching Starships",
                                  hintMessage: "Never tell me the odds!")
            } else {
                ForEach(filmDetailHandler.starships, id: \.self) { starship in
                    VStack(alignment: .leading) {
                        NavigationLink(value: starship) {
                            Text(starship.name)
                        }
                    }
                }
            }
        }
    }

    var vehicleLabel: some View {
        Group {
            if filmDetailHandler.fetchingVehicles {
                ActivityIndicator(title: "Fetching vehicles",
                                  hintMessage: "It's a trap!")
            } else {
                ForEach(filmDetailHandler.vehicles, id: \.self) { vehicle in
                    VStack(alignment: .leading) {
                        NavigationLink(value: vehicle) {
                            Text(vehicle.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FilmDetailView(film: .example)
}
