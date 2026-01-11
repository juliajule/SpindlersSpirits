//
//  FavoriteGridView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 11.01.26.
//

import SwiftUI

struct FavoriteGridView: View {
    
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @EnvironmentObject var favoritesManager: FavoritesManager
    var onSelect: (Whisky) -> Void

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var favoriteWhiskys: [Whisky] {
        favoritesManager.favorites(from: viewModel.whiskys)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Favoriten", iconName: "list.bullet") {
                withAnimation {
                    viewModeSettings.viewMode = .list
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
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(favoriteWhiskys) { whisky in
                                    WhiskyCellView(whisky: whisky)
                                        .onTapGesture {
                                            onSelect(whisky)
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
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
    FavoriteGridView(viewModel: viewModel, onSelect: onSelect)
        .environmentObject(ViewModeSettings())
        .environmentObject(FavoritesManager())
}

