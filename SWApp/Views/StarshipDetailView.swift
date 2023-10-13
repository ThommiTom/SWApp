//
//  StarshipDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct StarshipDetailView: View {
    let starship: Starship

    var body: some View {
        VStack(alignment: .leading) {
            Text(starship.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Model", value: starship.model)
                KeyValueLabel(key: "Manufacturer", value: starship.manufacturer)
                KeyValueLabel(key: "Class", value: starship.starshipClass)
                KeyValueLabel(key: "Max Atmospheric Speed", value: starship.maxAtmospheringSpeed)
                KeyValueLabel(key: "Hyperdrive Rating", value: starship.hyperdriveRating)
            }
        }
        .navigationTitle("Starship Details")
    }
}

#Preview {
    StarshipDetailView(starship: .example)
}
