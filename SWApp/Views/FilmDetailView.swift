//
//  FilmDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct FilmDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject var filmDetailHandler: FilmDetailHandler

    init(film: Film) {
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.push(.character(character))
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.push(.planet(planet))
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.push(.starship(starship))
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
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.push(.vehicle(vehicle))
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
