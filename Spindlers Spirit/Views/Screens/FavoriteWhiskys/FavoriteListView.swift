//
//  FavoriteListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 11.01.26.
//

import SwiftUI

struct FavoriteListView: View {
    
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @EnvironmentObject var favoritesManager: FavoritesManager
    var onSelect: (Whisky) -> Void

    private var favoriteWhiskys: [Whisky] {
        favoritesManager.favorites(from: viewModel.whiskys)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            HeaderView(title: "Favoriten", iconName: "square.grid.2x2") {
                withAnimation {
                    viewModeSettings.viewMode = .grid
                }
            }
            .zIndex(1)
            
            Group {
                if viewModel.isLoading {
                    ProgressView("Lade Whiskys...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if favoriteWhiskys.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Favoriten vorhanden.")
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(favoriteWhiskys) { whisky in
                                WhiskyRowView(whisky: whisky)
                                    .onTapGesture {
                                        onSelect(whisky)
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                    }
                    .transition(.opacity)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    let viewModel = WhiskyViewModel()
    let onSelect: (Whisky) -> Void = { _ in }
    FavoriteListView(viewModel: viewModel, onSelect: onSelect)
        .environmentObject(ViewModeSettings())
        .environmentObject(FavoritesManager())
}

