//
//  Caches.swift
//  SWApp
//
//  Created by Thomas Schatton on 29.10.23.
//

import Foundation

class Caches {
    private init() {
        characterCache = CacheManager<Character>()
        planetCache = CacheManager<Planet>()
        starshipCache = CacheManager<Starship>()
        vehicleCache = CacheManager<Vehicle>()
    }

    static var instance = Caches()

    let characterCache: CacheManager<Character>
    let planetCache: CacheManager<Planet>
    let starshipCache: CacheManager<Starship>
    let vehicleCache: CacheManager<Vehicle>
}
