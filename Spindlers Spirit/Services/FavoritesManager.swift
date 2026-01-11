//
//  FavoritesManager.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 11.01.26.
//

import Foundation

@MainActor
final class FavoritesManager: ObservableObject {
    
    @Published private(set) var favoriteWhiskyIDs: Set<Int> = []
    private let storageKey = "favoriteWhiskyIDs"
    private let defaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.defaults = userDefaults
        loadFavorites()
    }
    
    func isFavorite(_ whisky: Whisky) -> Bool {
        favoriteWhiskyIDs.contains(whisky.id)
    }
    
    func isFavorite(id: Int) -> Bool {
        favoriteWhiskyIDs.contains(id)
    }
    
    func toggleFavorite(_ whisky: Whisky) {
        if isFavorite(whisky) {
            favoriteWhiskyIDs.remove(whisky.id)
        } else {
            favoriteWhiskyIDs.insert(whisky.id)
        }
        saveFavorites()
    }
    
    func remove(_ whisky: Whisky) {
        favoriteWhiskyIDs.remove(whisky.id)
        saveFavorites()
    }
    
    func favorites(from all: [Whisky]) -> [Whisky] {
        all.filter { favoriteWhiskyIDs.contains($0.id) }
    }
    
    private func loadFavorites() {
        let ids = defaults.array(forKey: storageKey) as? [Int] ?? []
        favoriteWhiskyIDs = Set(ids)
    }
    
    private func saveFavorites() {
        defaults.set(Array(favoriteWhiskyIDs), forKey: storageKey)
    }
}

