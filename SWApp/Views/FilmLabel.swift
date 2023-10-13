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
        HStack {
            Text("Release Date")
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            Spacer()
            Text(film.releaseDate)
                .foregroundStyle(.secondary)
        }
        .font(.caption)
    }

    var directorLabel: some View {
        HStack {
            Text("Director")
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            Spacer()
            Text(film.director)
                .foregroundStyle(.secondary)
        }
        .font(.caption)
    }

    var producerLabel: some View {
        HStack {
            Text("Producer")
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
            Spacer()
            Text(film.producer)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .font(.caption)
    }
}

#Preview {
    FilmLabel(film: .example)
}
