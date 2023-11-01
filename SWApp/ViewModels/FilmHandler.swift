//
//  FilmHandler.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

class FilmHandler: ObservableObject {
    @Published var filmList = FilmList()
    @Published var isDownloading = false

    private let url: URL? = URL(string: "https://swapi.dev/api/films/")

    var sortedFilms: [Film] {
        filmList.results.sorted { $0.episodeId > $1.episodeId}
    }

    init() {
        // uses network call with completion handler
        // fetchStarWarsMovies()

        // uses network call with async throws network call and @MainActor
        getStarWarsMovies()
    }
}

// MARK: - extending FilmHandler by networking functionality
extension FilmHandler {
    // Does not work with @MainActor, need DispatchQueue.main.async { ... }
    private func fetchStarWarsMovies() {
        self.isDownloading = true
        Task {
            NetworkManager.networkCall(with: url) { [weak self] (result: Result<FilmList, NetworkError>) in
                guard let self = self else { return }

                switch result {
                case .success(let filmList):
                    DispatchQueue.main.async {
                        self.filmList = filmList

                        for film in filmList.results {
                            Caches.instance.filmCache.add(key: film.url, value: film)
                        }
                    }
                case .failure(let error):
                    print(error.rawValue)
                }

                DispatchQueue.main.async {
                    self.isDownloading = false
                }
            }
        }
    }

    // Does work with @MainActor
    private func getStarWarsMovies() {
        Task { @MainActor in
            isDownloading = true
            do {
                filmList = try await NetworkManager.networkCall(with: url)
                for film in filmList.results {
                    Caches.instance.filmCache.add(key: film.url, value: film)
                }
            } catch {
                print(error.localizedDescription)
            }
            isDownloading = false
        }
    }
}
