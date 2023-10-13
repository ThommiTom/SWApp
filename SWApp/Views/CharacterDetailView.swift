//
//  CharacterDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Birth year", value: character.birthYear)
                KeyValueLabel(key: "Gender", value: character.gender)
                KeyValueLabel(key: "Eye Color", value: character.eyeColor)
                KeyValueLabel(key: "Hair Color", value: character.hairColor)
                KeyValueLabel(key: "Height", value: character.height)
                KeyValueLabel(key: "Mass", value: character.mass)
            }
        }
        .navigationTitle("Character Details")
    }
}

#Preview {
    CharacterDetailView(character: .example)
}
