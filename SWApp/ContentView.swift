//
//  ContentView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var films = [Film]()
    @State private var isDownloading = false

    private var sortedFilms: [Film] {
        return films.sorted { $0.episodeId > $1.episodeId }
    }

    var filmUrls: [URL?] = []
    var dispatchGroup = DispatchGroup()

    init() {
        for episodeNo in 1...9 {
            var urlAsString = "https://swapi.dev/api/films/\(String(episodeNo))/"
            filmUrls.append(URL(string: urlAsString))
        }
    }

    var body: some View {
        VStack {
            if isDownloading {
                ProgressView()
            } else {
                ForEach(sortedFilms, id: \.self) {
                    Text($0.title)
                }
            }
        }
        .onAppear {
            getStarWarsMovies()
        }
        .padding()
    }

    private func getStarWarsMovies() {
        isDownloading = true
        for url in filmUrls {
            getStarWarsMovie(url: url)
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            isDownloading = false
        }
    }

    private func getStarWarsMovie(url: URL?) {
        dispatchGroup.enter()
        Task {
            await NetworkManager.shared.networkCall(with: url) { (result: Result<Film, NetworkError>) in
                switch result {
                case .success(let film):
                    DispatchQueue.main.async {
                        self.films.append(film)
                    }
                case .failure(let error):
                    print(error.rawValue)
                }

                dispatchGroup.leave()
            }
        }
    }
}

#Preview {
    ContentView()
}
