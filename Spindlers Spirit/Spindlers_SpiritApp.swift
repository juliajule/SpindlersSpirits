//
//  Spindlers_SpiritApp.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 19.03.25.
//

import SwiftUI

@main
struct Spindlers_SpiritApp: App {
    
    @StateObject private var viewModeSettings = ViewModeSettings()
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .environmentObject(viewModeSettings)
                .environmentObject(favoritesManager)
        }
    }
}

