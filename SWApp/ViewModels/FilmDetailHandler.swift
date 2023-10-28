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
        fetchFilmDetails()
    }
}

// MARK: - extending FilmDetailHandler by networking functionality
extension FilmDetailHandler {
    private func fetchFilmDetails() {
        fetchCharacters()
        fetchPlanets()
        fetchStarships()
        fetchVehicles()
    }

    private func fetchCharacters() {
        fetchingCharacters = true

        for url in film.characters {
            fetchCharacter(url: url)
        }

        characterGroup.notify(queue: DispatchQueue.main) {
            self.fetchingCharacters = false
        }
    }

    private func fetchCharacter(url: URL?) {
        characterGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { (result: Result<Character, NetworkError>) in
                switch result {
                case .success(let character):
                    self.characters.append(character)
//                    DispatchQueue.main.async {
//                        self.characters.append(character)
//                    }
                case .failure(let error):
                    print(error.rawValue)
                }

                self.characterGroup.leave()
            }
        }
    }

    private func fetchPlanets() {
        fetchingPlanets = true

        for url in film.planets {
            fetchPlanet(url: url)
        }

        planetGroup.notify(queue: DispatchQueue.main) {
            self.fetchingPlanets = false
        }
    }

    private func fetchPlanet(url: URL?) {
        planetGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { (result: Result<Planet, NetworkError>) in
                switch result {
                case .success(let planet):
                    DispatchQueue.main.async {
                        self.planets.append(planet)
                    }
                case .failure(let error):
                    print(error.rawValue)
                }

                self.planetGroup.leave()
            }
        }
    }

    private func fetchStarships() {
        fetchingStarships = true

        for url in film.starships {
            fetchStarship(url: url)
        }

        starshipGroup.notify(queue: DispatchQueue.main) {
            self.fetchingStarships = false
        }
    }

    private func fetchStarship(url: URL?) {
        starshipGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { (result: Result<Starship, NetworkError>) in
                switch result {
                case .success(let starship):
                    DispatchQueue.main.async {
                        self.starships.append(starship)
                    }
                case .failure(let error):
                    print(error.rawValue)
                }

                self.starshipGroup.leave()
            }
        }
    }

    private func fetchVehicles() {
        fetchingVehicles = true

        for url in film.vehicles {
            fetchVehicle(url: url)
        }

        vehicleGroup.notify(queue: DispatchQueue.main) {
            self.fetchingVehicles = false
        }
    }

    private func fetchVehicle(url: URL?) {
        vehicleGroup.enter()
        Task {
            NetworkManager.networkCall(with: url) { (result: Result<Vehicle, NetworkError>) in
                switch result {
                case .success(let vehicle):
                    DispatchQueue.main.async {
                        self.vehicles.append(vehicle)
                    }
                case .failure(let error):
                    print(error.rawValue)
                }

                self.vehicleGroup.leave()
            }
        }
    }
}
