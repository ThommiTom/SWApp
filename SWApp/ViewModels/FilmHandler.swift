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

    var filmUrls: [URL?] = []
    var dispatchGroup = DispatchGroup()

    init() {
        // assumption: swapi.dev provides data for all 9 episodes
        // observation: unfortantly REST calls to swapi often fail
        for episodeNo in 1...9 {
            let urlAsString = "https://swapi.dev/api/films/\(String(episodeNo))/"
            filmUrls.append(URL(string: urlAsString))
        }

        getStarWarsMovies()
    }
}

extension FilmHandler {
    private func getStarWarsMovies() {
        isDownloading = true
        for url in filmUrls {
            getStarWarsMovie(url: url)
        }

        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.isDownloading = false
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

                self.dispatchGroup.leave()
            }
        }
    }
}
