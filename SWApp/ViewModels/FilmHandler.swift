//
//  FilmHandler.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import Foundation
import Combine

class FilmHandler: ObservableObject {
    @Published var films = [Film]()
    @Published var isDownloading = false

    var cancellables = Set<AnyCancellable>()

    var sortedFilms: [Film] {
        return films.sorted { $0.episodeId > $1.episodeId }
    }

    let dataService: ProductionDataService<Film>

    init(dataService: ProductionDataService<Film>) {
        self.dataService = dataService
        loadData()
    }
}

// MARK: - extending FilmHandler by networking functionality
extension FilmHandler {
    private func loadData() {
        isDownloading = true
        dataService.fetchData()
            .sink { _ in

            } receiveValue: { [weak self] returnedItems in
                self?.films = returnedItems
                self?.isDownloading = false
            }
            .store(in: &cancellables)
    }
}
