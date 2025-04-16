//
//  TastingListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import SwiftUI

struct TastingListView: View {
    
    @StateObject private var viewModel = TastingListViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header mit Umschaltbutton
                HeaderView(title: "Verkostungen", iconName: "square.grid.2x2") {
                    withAnimation {
                        viewModel.isGridView = true
                    }
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
                                            // Detailnavigation
                                        }
                                }
                                //.padding(.horizontal)
                            }
                            .padding(.top)
                        }
                        .transition(.opacity)
                    }
                }
                //.animation(.easeInOut, value: viewModel.tastings)
            }
            .task {
                await viewModel.fetchTastings()
            }
        }
    }
}

#Preview {
    TastingListView()
}
