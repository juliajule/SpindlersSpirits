//
//  AllWhiskyGridView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 19.04.25.
//

import SwiftUI

struct AllWhiskyGridView: View {
    
    @ObservedObject var viewModel: WhiskyViewModel
    @EnvironmentObject var viewModeSettings: ViewModeSettings

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Whiskys", iconName: "list.bullet") {
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
                } else if viewModel.whiskys.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Whiskys gefunden.")
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.whiskys) { whisky in
                                    WhiskyCellView(whisky: whisky)
                                        .onTapGesture {
                                            // Detailnavigation (geplant)
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
    AllWhiskyGridView(viewModel: viewModel)
}
