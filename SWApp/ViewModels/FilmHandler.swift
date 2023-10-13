//
//  FilmHandler.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

class FilmHandler: ObservableObject {
    @Published var films = [Film]()
    @Published var isDownloading = false

    var sortedFilms: [Film] {
        return films.sorted { $0.episodeId > $1.episodeId }
    }

    private var filmUrls: [URL?] = []
    private var filmGroup = DispatchGroup()

    init() {
        // assumption: swapi.dev provides data for all 9 episodes
        // observation: unfortantly REST calls to swapi often fail
        for episodeNo in 1...9 {
            let urlAsString = "https://swapi.dev/api/films/\(String(episodeNo))/"
            filmUrls.append(URL(string: urlAsString))
        }

        fetchStarWarsMovies()
    }
}

// MARK: - extending FilmHandler by networking functionality
extension FilmHandler {
    private func fetchStarWarsMovies() {
        isDownloading = true
        for url in filmUrls {
            fetchStarWarsMovie(url: url)
        }

        filmGroup.notify(queue: DispatchQueue.main) {
            self.isDownloading = false
        }
    }

    private func fetchStarWarsMovie(url: URL?) {
        filmGroup.enter()
        Task {
            await NetworkManager.shared.networkCall(with: url) { (result: Result<Film, NetworkError>) in
                switch result {
                case .success(let film):
                    DispatchQueue.main.async {
                        self.films.append(film)
                    }
                case .failure(let error):
                    // TODO: create a mechanism to provide user about failure cases
                    print(error.rawValue)
                }

                self.filmGroup.leave()
            }
        }
    }
}
