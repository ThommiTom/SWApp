//
//  AppCoordinator.swift
//  SWApp
//
//  Created by Thomas Schatton on 17.11.23.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
}

extension AppCoordinator {
    @MainActor func push(_ route: Route) {
        navigationPath.append(route)
    }

    @MainActor func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }

    @MainActor func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }

    var reached2ndLvl: Bool { navigationPath.count > 1 }
}
