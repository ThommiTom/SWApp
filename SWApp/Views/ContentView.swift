//
//  ContentView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var filmHandler = FilmHandler()

    var body: some View {
        NavigationStack {
            Group {
                if filmHandler.isDownloading {
                    ActivityIndicator(title: "Fetching movies",
                                      hintMessage: "This API is sloooww...\nso this might take a while...")
                } else {
                    List(filmHandler.sortedFilms, id: \.self) { film in
                        NavigationLink(value: film) {
                            FilmLabel(film: film)
                        }
                    }
                }
            }
            .navigationTitle("Star Wars Library")
            .navigationDestination(for: Film.self) { film in
                FilmDetailView(film: film)
            }
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
    }
}

#Preview {
    ContentView()
}
