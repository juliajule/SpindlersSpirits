//
//  TastingGridView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 15.04.25.
//

import SwiftUI

struct TastingGridView: View {
    
    @StateObject private var viewModel = TastingListViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header mit Umschaltbutton
                HeaderView(title: "Verkostungen", iconName: "list.bullet") {
                    withAnimation {
                        viewModel.isGridView = false
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
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.tastings) { tasting in
                                    TastingCellView(tasting: tasting)
                                        .onTapGesture {
                                            // Detailnavigation
                                        }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
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
    TastingGridView()
}
