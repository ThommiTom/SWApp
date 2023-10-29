//
//  Cache.swift
//  SWApp
//
//  Created by Thomas Schatton on 29.10.23.
//

import Foundation
// extending by Generic CacheManager class
extension Caches {
    final class CacheManager<T> {
        private var cache: NSCache<NSString, Entry<T>> = {
            let cache = NSCache<NSString, Entry<T>>()
            cache.countLimit = 250
            cache.totalCostLimit = 1024 * 1024 * 100 // ~100mb
            return cache
        }()

        func add(key: URL, value: T) {
            print("Adding item \(key.absoluteString) to \(getTypeAsString(for: value))")
            cache.setObject(Entry<T>(value: value), forKey: NSString(string: key.absoluteString))
        }

        func get(key: URL) -> T? {
            guard let value = cache.object(forKey: NSString(string: key.absoluteString))?.value else { return nil }

            print("Getting item \(key.absoluteString) from \(getTypeAsString(for: value))")
            return value
        }

        private func getTypeAsString(for value: T) -> String {
            switch value {
            case is Character:
                return "Character-Cache"
            case is Planet:
                return "Planet-Cache"
            case is Starship:
                return "Starship-Cache"
            case is Vehicle:
                return "Vehicle-Cache"
            default:
                return "Unknown Cache"
            }
        }
    }

    private final class Entry<T> {
        let value: T

        init(value: T) {
            self.value = value
        }
    }
}
