//
//  TastingGridView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 15.04.25.
//

import SwiftUI

struct TastingGridView: View {
    
    @ObservedObject var viewModel: TastingViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    //@State private var selectedTasting: Tasting?
    var onSelect: (Tasting) -> Void

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Verkostungen", iconName: "list.bullet") {
                withAnimation {
                    viewModeSettings.viewMode = .list                    }
            }
            .zIndex(1)

            Group {
                if viewModel.isLoading {
                    ProgressView("Lade Verkostungen...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.tastings.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Verkostungen gefunden.")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.tastings) { tasting in
                                TastingCellView(tasting: tasting)
                                    .onTapGesture {
                                        print("Tapped: ")
                                        onSelect(tasting)
                                    }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
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
    TastingGridView(viewModel: viewModel, onSelect: onSelect)
}
