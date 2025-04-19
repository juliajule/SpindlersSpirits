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
    @State private var selectedTasting: Tasting?

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(title: "Verkostungen", iconName: "list.bullet") {
                    withAnimation {
                        viewModeSettings.viewMode = .list                    }
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
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.tastings) { tasting in
                                    TastingCellView(tasting: tasting)
                                        .onTapGesture {
                                            selectedTasting = tasting
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
            .navigationDestination(item: $selectedTasting) { tasting in
                WhiskyTabView(tasting: tasting)
            }
        }
    }
}

#Preview {
    let viewModel = TastingViewModel()
    TastingGridView(viewModel: viewModel)
}
