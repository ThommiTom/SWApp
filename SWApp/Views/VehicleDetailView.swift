//
//  VehicleDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct VehicleDetailView: View {
    let vehicle: Vehicle

    var body: some View {
        VStack(alignment: .leading) {
            Text(vehicle.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Manufacturer", value: vehicle.manufacturer)
                KeyValueLabel(key: "Class", value: vehicle.vehicleClass)
                KeyValueLabel(key: "Max Atmospheric Speed", value: vehicle.maxAtmospheringSpeed)
            }
        }
        .navigationTitle("Starship Details")
    }
}

#Preview {
    VehicleDetailView(vehicle: .example)
}
