//
//  AllWhiskyListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 19.04.25.
//

import SwiftUI

struct AllWhiskyListView: View {
    
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    var onSelect: (Whisky) -> Void

    var body: some View {
        VStack(spacing: 0) {
            
            HeaderView(title: "Whiskys", iconName: "square.grid.2x2") {
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
    AllWhiskyListView(viewModel: viewModel, onSelect: onSelect)
}
