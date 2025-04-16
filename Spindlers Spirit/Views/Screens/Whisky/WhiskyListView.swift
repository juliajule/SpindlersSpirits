//
//  WhiskyListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct WhiskyListView: View {
    
    let tasting: Tasting
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                HeaderView(title: "Whiskys", iconName: "square.grid.2x2") {
                    withAnimation {
                        viewModeSettings.viewMode = .grid
                    }
                }
                .zIndex(1)
                
                VStack(spacing: 4) {
                    Text("Tasting: \(tasting.name)")
                        .font(.headline)
                    Text(tasting.date.formatted(date: .long, time: .omitted))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)

                Group {
                    if viewModel.isLoading {
                        ProgressView("Lade Whiskys...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else if viewModel.whiskys.isEmpty {
                        EmptyStateView(imageName: "whisky-def", message: "Keine Whiskys gefunden.")
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(viewModel.whiskys) { whisky in
                                    WhiskyRowView(whisky: whisky)
                                        .onTapGesture {
                                            // Detailnavigation (geplant)
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
}

#Preview {
    let viewModel = WhiskyViewModel()
    WhiskyListView(tasting: MockData.mockTastings[0], viewModel: viewModel)
}
