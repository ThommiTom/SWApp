//
//  SWAppApp.swift
//  SWApp
//
//  Created by Thomas Schatton on 13.10.23.
//

import SwiftUI

@main
struct SWAppApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
