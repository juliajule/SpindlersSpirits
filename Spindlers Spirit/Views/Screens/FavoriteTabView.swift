//
//  FavoriteTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 11.01.26.
//

import SwiftUI

struct FavoriteTabView: View {
    
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @EnvironmentObject var favoritesManager: FavoritesManager
    @StateObject private var viewModel = WhiskyViewModel()
    @State private var selectedWhisky: Whisky?
    @State private var isWhiskyLinkActive = false
    
    private var favoriteWhiskys: [Whisky] {
        favoritesManager.favorites(from: viewModel.whiskys)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModeSettings.viewMode == .list {
                    FavoriteListView(viewModel: viewModel, onSelect: { whisky in
                        selectedWhisky = whisky
                        isWhiskyLinkActive = true
                    })
                } else {
                    FavoriteGridView(viewModel: viewModel, onSelect: { whisky in
                        selectedWhisky = whisky
                        isWhiskyLinkActive = true
                    })
                }
            }
            .navigationDestination(isPresented: $isWhiskyLinkActive) {
                if let whisky = selectedWhisky {
                    WhiskyDetailView(whisky: whisky)
                }
            }
        }
        .task {
            await viewModel.fetchWhiskys()
        }
        // WICHTIG: Die Unterviews filtern selbst anhand favoritesManager,
        // deshalb müssen sie Zugriff bekommen (via EnvironmentObject).
    }
}

#Preview {
    FavoriteTabView()
        .environmentObject(ViewModeSettings())
        .environmentObject(FavoritesManager())
}

