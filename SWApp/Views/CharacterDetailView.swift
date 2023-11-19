//
//  CharacterDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct CharacterDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    @StateObject var handler: CharacterHandler

    init(character: Character) {
        self._handler = StateObject(wrappedValue: CharacterHandler(character: character))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(handler.character.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Birth year", value: handler.character.birthYear)
                KeyValueLabel(key: "Gender", value: handler.character.gender)
                KeyValueLabel(key: "Eye Color", value: handler.character.eyeColor)
                KeyValueLabel(key: "Hair Color", value: handler.character.hairColor)
                KeyValueLabel(key: "Height", value: handler.character.height)
                KeyValueLabel(key: "Mass", value: handler.character.mass)

                playedInSection
                flownStarshipsSection
                drivenVehicleSection
            }
        }
        .navigationTitle("Character Details")
    }

    var playedInSection: some View {
        Group {
            if !handler.moviesPlayed.isEmpty {
                Section("Played in") {
                    ForEach(handler.moviesPlayed, id: \.self) { film in
                        NavigationLink(value: film) {
                            Text(film.title)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            coordinator.push(.film(film))
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder var flownStarshipsSection: some View {
        if !handler.starshipsFlown.isEmpty {
            Section("Flown Starships") {
                ForEach(handler.starshipsFlown, id: \.self) { starship in
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

    @ViewBuilder var drivenVehicleSection: some View {
        if !handler.vehiclesDriven.isEmpty {
            Section("Driven Vehicles") {
                ForEach(handler.vehiclesDriven, id: \.self) { vehicle in
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

#Preview {
    CharacterDetailView(character: .example)
}
