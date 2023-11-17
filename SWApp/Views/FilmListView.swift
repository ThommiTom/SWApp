//
//  FilmList.swift
//  SWApp
//
//  Created by Thomas Schatton on 17.11.23.
//

import SwiftUI

struct FilmListView: View {
    @EnvironmentObject var coordinator: AppCoordinator

    let films: [Film]

    var body: some View {
        List(films, id: \.self) { film in
            FilmLabel(film: film)
                .contentShape(Rectangle())
                .onTapGesture {
                    coordinator.push(.film(film))
                }
        }
    }
}

#Preview {
    FilmListView(films: FilmList().results)
}
