//
//  PlanetDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet

    var body: some View {
        VStack(alignment: .leading) {
            Text(planet.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Population", value: planet.population)
                KeyValueLabel(key: "Climate", value: planet.climate)
                KeyValueLabel(key: "Terrain", value: planet.terrain)
                KeyValueLabel(key: "Gravity", value: planet.gravity)
                KeyValueLabel(key: "Diameter", value: planet.diameter)
                KeyValueLabel(key: "Rotation Period", value: planet.rotationPeriod)
                KeyValueLabel(key: "Orbital Period", value: planet.orbitalPeriod)
            }
        }
        .navigationTitle("Planet Details")
    }
}

#Preview {
    PlanetDetailView(planet: .example)
}
