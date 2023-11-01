//
//  CharacterDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var moviesPlayed = [Film]()
    var starshipsFlown = [Starship]()
    var vehiclesRiden = [Vehicle]()

    init(character: Character) {
        self.character = character

        self.moviesPlayed = gatherFilmData(for: character.films)
        self.starshipsFlown = []
        self.vehiclesRiden = []
    }

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

                playedInSection
            }
        }
        .navigationTitle("Character Details")
    }

    var playedInSection: some View {
        Section("Played in") {
            ForEach(moviesPlayed, id: \.self) { film in
                NavigationLink(value: film) {
                    VStack(alignment: .leading) {
                        Text(film.title)
                    }
                }
            }
        }
    }

    private func gatherFilmData(for urls: [URL]) -> [Film] {
        var movies = [Film]()

        for url in urls {
            if let movie = Caches.instance.filmCache.get(key: url) {
                movies.append(movie)
            } else {
                // fetch data from server
                if let fetchedFilm = fetchMovie(for: url) {
                    movies.append(fetchedFilm)
                }
            }
        }

        return movies
    }

    private func fetchMovie(for url: URL) -> Film? {
        var film: Film?

        NetworkManager.networkCall(with: url) { (result: Result<Film, NetworkError>) in
            switch result {
            case .success(let fetchedFilm):
                film = fetchedFilm
            case .failure:
                film = nil
            }
        }
        return film
    }
}

#Preview {
    CharacterDetailView(character: .example)
}
