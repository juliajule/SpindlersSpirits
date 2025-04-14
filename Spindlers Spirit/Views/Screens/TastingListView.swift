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
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Lade Tastings...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else if viewModel.tastings.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Tastings gefunden.")
                } else {
                    List(viewModel.tastings) { tasting in
                        VStack(alignment: .leading) {
                            Text(tasting.name)
                                .font(.headline)
                            Text(tasting.date)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Verkostungen")
        }
        .task {
            await viewModel.fetchTastings()
        }
    }
}

#Preview {
    TastingListView()
}
