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
        _filmDetailHandler = StateObject(wrappedValue: FilmDetailHandler(film: film))
    }

    var body: some View {
        List {
            FilmLabel(film: filmDetailHandler.film)

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
                                  hintMessage: "Please wait...")
            } else {
                ForEach(filmDetailHandler.characters, id: \.self) { character in
                    VStack(alignment: .leading) {
                        Text(character.name)
                    }
                }
            }
        }
    }

    var planetLabel: some View {
        Group {
            if filmDetailHandler.fetchingPlanets {
                ActivityIndicator(title: "Fetching Planets",
                                  hintMessage: "Please wait...")
            } else {
                ForEach(filmDetailHandler.planets, id: \.self) { planet in
                    VStack(alignment: .leading) {
                        Text(planet.name)
                    }
                }
            }
        }
    }

    var starshipLabel: some View {
        Group {
            if filmDetailHandler.fetchingStarships {
                ActivityIndicator(title: "Fetching Starships",
                                  hintMessage: "Please wait...")
            } else {
                ForEach(filmDetailHandler.starships, id: \.self) { starship in
                    VStack(alignment: .leading) {
                        Text(starship.name)
                    }
                }
            }
        }
    }

    var vehicleLabel: some View {
        Group {
            if filmDetailHandler.fetchingVehicles {
                ActivityIndicator(title: "Fetching vehicles",
                                  hintMessage: "Please wait...")
            } else {
                ForEach(filmDetailHandler.vehicles, id: \.self) { vehicle in
                    VStack(alignment: .leading) {
                        Text(vehicle.name)
                    }
                }
            }
        }
    }
}

#Preview {
    FilmDetailView(film: .example)
}
