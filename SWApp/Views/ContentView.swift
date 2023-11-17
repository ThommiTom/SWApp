//
//  ContentView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject var filmHandler = FilmHandler()

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            Group {
                switch filmHandler.viewState {
                case .none:
                    EmptyView()
                case .downloadingData:
                    ActivityIndicator(title: "Fetching movies",
                                      hintMessage: "This API is sloooww...\nso this might take a while...")
                case .presentingData:
                    FilmListView(films: filmHandler.sortedFilms)
                case .presentDownloadError(let error):
                    ErrorView(error: error, retryMeasure: filmHandler.getStarWarsMovies)
                }
            }
            .navigationTitle("Star Wars Library")
            .navigationDestination(for: Route.self, destination: { $0 })
        }
    }
}

#Preview {
    ContentView()
}
