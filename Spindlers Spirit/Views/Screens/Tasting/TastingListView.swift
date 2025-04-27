//
//  TastingListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import SwiftUI

struct TastingListView: View {
    
    @ObservedObject var viewModel: TastingViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    var onSelect: (Tasting) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Verkostungen", iconName: "square.grid.2x2") {
                withAnimation {
                    viewModeSettings.viewMode = .grid                    }
            }
            .zIndex(1)

            Group {
                if viewModel.isLoading {
                    ProgressView("Lade Tastings...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.tastings.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Tastings gefunden.")
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.tastings) { tasting in
                                TastingRowView(tasting: tasting)
                                    .onTapGesture {
                                        onSelect(tasting)
                                    }
                            }
                        }
                        .padding(.top)
                    }
                    .transition(.opacity)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    let viewModel = TastingViewModel()
    let onSelect: (Tasting) -> Void = { _ in }
    TastingListView(viewModel: viewModel, onSelect: onSelect)
}
