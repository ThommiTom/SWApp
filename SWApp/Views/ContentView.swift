//
//  ContentView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var filmHandler = FilmHandler()

    var body: some View {
        NavigationStack {
            Group {
                if filmHandler.isDownloading {
                    ActivityIndicator(title: "Fetching movies",
                                      hintMessage: "This might take a while...")
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
                VStack(content: {
                    Text("WIP: Film Details coming here for")
                    Text(film.title)
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
