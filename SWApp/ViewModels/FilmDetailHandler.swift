//
//  FilmDetailHandler.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation

class FilmDetailHandler: ObservableObject {
    @Published var characters = [Character]()
    @Published var planets = [Planet]()
    @Published var starships = [Starship]()
    @Published var vehicles = [Vehicle]()

    @Published var fetchingCharacters = false
    @Published var fetchingPlanets = false
    @Published var fetchingStarships = false
    @Published var fetchingVehicles = false

    let film: Film

    private var characterGroup = DispatchGroup()
    private var planetGroup = DispatchGroup()
    private var starshipGroup = DispatchGroup()
    private var vehicleGroup = DispatchGroup()

    init(film: Film) {
        self.film = film
        getFilmDetails()
    }
}

// MARK: - extending FilmDetailHandler by networking functionality
extension FilmDetailHandler {
    private func getFilmDetails() {
        getCharacters()
        getPlanets()
        getStarships()
        fetchVehicles()
    }

    // MARK: - Characters
    private func getCharacters() {
        fetchingCharacters = true

        for url in film.characters {
            handleCharacterURL(for: url)
        }

        characterGroup.notify(queue: DispatchQueue.main) {
            self.fetchingCharacters = false
        }
    }

    // gets character either from cache or server
    private func handleCharacterURL(for url: URL?) {
        guard let unwrappedURL = url else { return }

        if let character = Caches.instance.characterCache.get(key: unwrappedURL) {
            self.characters.append(character)
        } else {
            fetchCharacter(with: url)
        }
    }

    // fetches character from server
    private func fetchCharacter(with url: URL?) {
        characterGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { [weak self] (result: Result<Character, NetworkError>) in
                guard let self = self else { return }

                switch result {
                case .success(let character):
                    DispatchQueue.main.async {
                        self.characters.append(character)
                    }
                    Caches.instance.characterCache.add(key: url!, value: character)
                case .failure(let error):
                    print(error.rawValue)
                }

                self.characterGroup.leave()
            }
        }
    }

    // MARK: - Planets
    private func getPlanets() {
        fetchingPlanets = true

        for url in film.planets {
            handlePlanetURL(for: url)
        }

        planetGroup.notify(queue: DispatchQueue.main) {
            self.fetchingPlanets = false
        }
    }

    // gets planet either from cache or server
    private func handlePlanetURL(for url: URL?) {
        guard let unwrappedURL = url else { return }

        if let planet = Caches.instance.planetCache.get(key: unwrappedURL) {
            self.planets.append(planet)
        } else {
            fetchPlanet(with: url)
        }
    }

    // fetches planet from server
    private func fetchPlanet(with url: URL?) {
        planetGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { [weak self] (result: Result<Planet, NetworkError>) in
                guard let self = self else { return }

                switch result {
                case .success(let planet):
                    DispatchQueue.main.async {
                        self.planets.append(planet)
                    }
                    Caches.instance.planetCache.add(key: url!, value: planet)
                case .failure(let error):
                    print(error.rawValue)
                }

                self.planetGroup.leave()
            }
        }
    }

    // MARK: - Starships
    private func getStarships() {
        fetchingStarships = true

        for url in film.starships {
            handleStarshipURL(for: url)
        }

        starshipGroup.notify(queue: DispatchQueue.main) {
            self.fetchingStarships = false
        }
    }

    // gets starship either from cache or server
    private func handleStarshipURL(for url: URL?) {
        guard let unwrappedURL = url else { return }

        if let starship = Caches.instance.starshipCache.get(key: unwrappedURL) {
            self.starships.append(starship)
        } else {
            fetchStarship(url: url)
        }
    }

    // fetches starship from server
    private func fetchStarship(url: URL?) {
        starshipGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { [weak self] (result: Result<Starship, NetworkError>) in
                guard let self = self else { return }

                switch result {
                case .success(let starship):
                    DispatchQueue.main.async {
                        self.starships.append(starship)
                    }
                    Caches.instance.starshipCache.add(key: url!, value: starship)
                case .failure(let error):
                    print(error.rawValue)
                }

                self.starshipGroup.leave()
            }
        }
    }

    // MARK: - Vehicles
    private func fetchVehicles() {
        fetchingVehicles = true

        for url in film.vehicles {
            handleVehicleURL(for: url)
        }

        vehicleGroup.notify(queue: DispatchQueue.main) {
            self.fetchingVehicles = false
        }
    }

    // gets vehicle either from cache or server
    private func handleVehicleURL(for url: URL?) {
        guard let unwrappedURL = url else { return }

        if let vehicle = Caches.instance.vehicleCache.get(key: unwrappedURL) {
            self.vehicles.append(vehicle)
        } else {
            fetchVehicle(url: url)
        }
    }

    // fetches vehicle from server
    private func fetchVehicle(url: URL?) {
        vehicleGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { [weak self] (result: Result<Vehicle, NetworkError>) in
                guard let self = self else { return }

                switch result {
                case .success(let vehicle):
                    DispatchQueue.main.async {
                        self.vehicles.append(vehicle)
                    }
                    Caches.instance.vehicleCache.add(key: url!, value: vehicle)
                case .failure(let error):
                    print(error.rawValue)
                }

                self.vehicleGroup.leave()
            }
        }
    }
}
