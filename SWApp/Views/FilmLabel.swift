//
//  FilmLabel.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct FilmLabel: View {
    let film: Film

    var body: some View {
        VStack(alignment: .leading) {
            Text(film.title)
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom, 7)

            releaseDateLabel
            directorLabel
            producerLabel
        }
    }

    var releaseDateLabel: some View {
        KeyValueLabel(key: "Release Date",
                      value: film.releaseDate)
    }

    var directorLabel: some View {
        KeyValueLabel(key: "Director",
                      value: film.director)
    }

    var producerLabel: some View {
        KeyValueLabel(key: "Producer",
                      value: film.producer)
        .lineLimit(1)
    }
}

#Preview {
    FilmLabel(film: .example)
}
