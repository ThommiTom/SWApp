//
//  PlanetDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct PlanetDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    @StateObject var handler: PlanetHandler

    init(planet: Planet) {
        self._handler = StateObject(wrappedValue: PlanetHandler(planet: planet))
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(handler.planet.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Population", value: handler.planet.population)
                KeyValueLabel(key: "Climate", value: handler.planet.climate)
                KeyValueLabel(key: "Terrain", value: handler.planet.terrain)
                KeyValueLabel(key: "Gravity", value: handler.planet.gravity)
                KeyValueLabel(key: "Diameter", value: handler.planet.diameter)
                KeyValueLabel(key: "Rotation Period", value: handler.planet.rotationPeriod)
                KeyValueLabel(key: "Orbital Period", value: handler.planet.orbitalPeriod)

                moviesThisPlanetAppeared
                residentsLivingHere
            }
        }
        .navigationTitle("Planet Details")
    }

    @ViewBuilder var moviesThisPlanetAppeared: some View {
        if !handler.movieAppearance.isEmpty {
            Section("Appeared in ...") {
                ForEach(handler.movieAppearance, id: \.self) { movie in
                    NavigationLink(value: movie) {
                        Text(movie.title)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.push(.film(movie))
                    }
                }
            }
        }
    }

    @ViewBuilder var residentsLivingHere: some View {
        if !handler.residents.isEmpty {
            Section("Who lives here...") {
                ForEach(handler.residents, id: \.self) { resident in
                    NavigationLink(value: resident) {
                        Text(resident.name)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        coordinator.push(.character(resident))
                    }
                }
            }
        }
    }
}

#Preview {
    PlanetDetailView(planet: .example)
}
