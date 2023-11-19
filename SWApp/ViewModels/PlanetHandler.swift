//
//  PlanetHandler.swift
//  SWApp
//
//  Created by Thomas Schatton on 19.11.23.
//

import Foundation

class PlanetHandler: ObservableObject {
    let planet: Planet

    @Published var movieAppearance = [Film]()
    @Published var residents = [Character]()

    init(planet: Planet) {
        self.planet = planet
        getFeaturedInfo()
    }

    func getFeaturedInfo() {
        self.movieAppearance = gatherMovieAppearances(for: planet.films)
        self.residents = gatherResidents(for: planet.residents)
    }

    private func gatherMovieAppearances(for urls: [URL]) -> [Film] {
        var movies = [Film]()

        for url in urls {
            if let movie = Caches.instance.filmCache.get(key: url) {
                movies.append(movie)
            } else {
                if let fetchedMovie: Film = NetworkManager.fetchData(with: url) {
                    movies.append(fetchedMovie)
                }
            }
        }

        return movies
    }

    private func gatherResidents(for urls: [URL]) -> [Character] {
        var residents = [Character]()

        for url in urls {
            if let resident = Caches.instance.characterCache.get(key: url) {
                residents.append(resident)
            } else {
                if let fetchedResident: Character = NetworkManager.fetchData(with: url) {
                    residents.append(fetchedResident)
                }
            }
        }

        return residents
    }
}
