//
//  CharacterHandler.swift
//  SWApp
//
//  Created by Thomas Schatton on 19.11.23.
//

import Foundation

class CharacterHandler: ObservableObject {
    let character: Character

    @Published var moviesPlayed = [Film]()
    @Published var starshipsFlown = [Starship]()
    @Published var vehiclesDriven = [Vehicle]()

    init(character: Character) {
        self.character = character
        getFeaturedInfo()
    }

    private func getFeaturedInfo() {
        print("getting featured data")
        moviesPlayed = gatherFilmData(for: character.films)
        starshipsFlown = gatherStarshipData(for: character.starships)
        vehiclesDriven = gatherVehicleData(for: character.vehicles)
    }

    private func gatherFilmData(for urls: [URL]) -> [Film] {
        var movies = [Film]()

        for url in urls {
            if let movie = Caches.instance.filmCache.get(key: url) {
                movies.append(movie)
            } else {
                // fetch data from server
                if let fetchedFilm: Film = NetworkManager.fetchData(with: url) {
                    movies.append(fetchedFilm)
                }
            }
        }

        print("got \(movies.count) movie related data sets")

        return movies
    }

    private func gatherStarshipData(for urls: [URL]) -> [Starship] {
        var starships = [Starship]()

        for url in urls {
            if let starship = Caches.instance.starshipCache.get(key: url) {
                starships.append(starship)
            } else {
                if let fetchedStarship: Starship = NetworkManager.fetchData(with: url) {
                    starships.append(fetchedStarship)
                }
            }
        }

        print("got \(starships.count) starship related data sets")

        return starships
    }

    private func gatherVehicleData(for urls: [URL]) -> [Vehicle] {
        var vehicles = [Vehicle]()

        for url in urls {
            if let vehicle = Caches.instance.vehicleCache.get(key: url) {
                vehicles.append(vehicle)
            } else {
                if let fetchedVehicle: Vehicle = NetworkManager.fetchData(with: url) {
                    vehicles.append(fetchedVehicle)
                }
            }
        }

        print("got \(vehicles.count) vehicle related data sets")

        return vehicles
    }
}
