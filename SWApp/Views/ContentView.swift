//
//  ContentView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var filmHandler: FilmHandler

    init() {
        var filmUrls = [URL?]()

        for episodeNo in 1...9 {
            let urlAsString = "https://swapi.dev/api/films/\(String(episodeNo))/"
            filmUrls.append(URL(string: urlAsString))
        }

        let dataService = ProductionDataService<Film>(urls: filmUrls)

        _filmHandler = StateObject(wrappedValue: FilmHandler(dataService: dataService))
    }

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
        }
    }
}

#Preview {
    ContentView()
}
