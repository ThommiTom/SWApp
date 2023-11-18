//
//  CharacterDetailView.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

struct CharacterDetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    let character: Character

    var moviesPlayed = [Film]()
    var starshipsFlown = [Starship]()
    var vehiclesDriven = [Vehicle]()

    init(character: Character) {
        self.character = character

        self.moviesPlayed = gatherFilmData(for: character.films)
        self.starshipsFlown = gatherStarshipData(for: character.starships)
        self.vehiclesDriven = gatherVehicleData(for: character.vehicles)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title2)
                .fontWeight(.semibold)
                .padding()

            List {
                KeyValueLabel(key: "Birth year", value: character.birthYear)
                KeyValueLabel(key: "Gender", value: character.gender)
                KeyValueLabel(key: "Eye Color", value: character.eyeColor)
                KeyValueLabel(key: "Hair Color", value: character.hairColor)
                KeyValueLabel(key: "Height", value: character.height)
                KeyValueLabel(key: "Mass", value: character.mass)

                playedInSection
                flownStarshipsSection
            }
        }
        .navigationTitle("Character Details")
    }

    var playedInSection: some View {
        Section("Played in") {
            ForEach(moviesPlayed, id: \.self) { film in
                NavigationLink(value: film) {
                    Text(film.title)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.push(.film(film))
                }
            }
        }
    }

    private func gatherFilmData(for urls: [URL]) -> [Film] {
        var movies = [Film]()

        for url in urls {
            if let movie = Caches.instance.filmCache.get(key: url) {
                movies.append(movie)
            } else {
                // fetch data from server
                if let fetchedFilm = fetchMovie(for: url) {
                    movies.append(fetchedFilm)
                }
            }
        }

        return movies
    }

    private func fetchMovie(for url: URL) -> Film? {
        var film: Film?

        NetworkManager.networkCall(with: url) { (result: Result<Film, NetworkError>) in
            switch result {
            case .success(let fetchedFilm):
                film = fetchedFilm
            case .failure:
                film = nil
            }
        }
        return film
    }

    var flownStarshipsSection: some View {
        Section("Flown Starships") {
            ForEach(starshipsFlown, id: \.self) { starship in
                NavigationLink(value: starship) {
                    Text(starship.name)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.push(.starship(starship))
                }
            }
        }
    }

    private func gatherStarshipData(for urls: [URL]) -> [Starship] {
        var starships = [Starship]()

        for url in urls {
            if let starship = Caches.instance.starshipCache.get(key: url) {
                starships.append(starship)
            } else {
                if let fetchedStarship = fetchStarship(for: url) {
                    starships.append(fetchedStarship)
                }
            }
        }
        return starships
    }

    private func fetchStarship(for url: URL) -> Starship? {
        var starship: Starship?

        NetworkManager.networkCall(with: url) { (result: Result<Starship, NetworkError>) in
            switch result {
            case .success(let fetchedStarship):
                starship = fetchedStarship
            case .failure:
                starship = nil
            }
        }
        return starship
    }

    var drivenVehicleSection: some View {
        Section("Driven Vehicles") {
            ForEach(vehiclesDriven, id: \.self) { vehicle in
                NavigationLink(value: vehicle) {
                    Text(vehicle.name)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.push(.vehicle(vehicle))
                }
            }
        }
    }

    private func gatherVehicleData(for urls: [URL]) -> [Vehicle] {
        var vehicles = [Vehicle]()

        for url in urls {
            if let vehicle = Caches.instance.vehicleCache.get(key: url) {
                vehicles.append(vehicle)
            } else {
                if let fetchedVehicle = fetchVehicle(for: url) {
                    vehicles.append(fetchedVehicle)
                }
            }
        }

        return vehicles
    }

    private func fetchVehicle(for url: URL) -> Vehicle? {
        var vehicle: Vehicle?

        NetworkManager.networkCall(with: url) { (result: Result<Vehicle, NetworkError>) in
            switch result {
            case .success(let fetchedVehicle):
                vehicle = fetchedVehicle
            case .failure:
                vehicle = nil
            }
        }

        return vehicle
    }
}

#Preview {
    CharacterDetailView(character: .example)
}
