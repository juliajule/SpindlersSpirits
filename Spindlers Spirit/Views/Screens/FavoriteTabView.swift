//
//  FavoriteTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 11.01.26.
//

import SwiftUI

struct FavoriteTabView: View {
    
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @StateObject private var viewModel = WhiskyViewModel()
    @State private var selectedWhisky: Whisky?
    @State private var isWhiskyLinkActive = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModeSettings.viewMode == .list {
                    FavoriteListView(viewModel: viewModel, onSelect: { whisky in
                        selectedWhisky = whisky
                        isWhiskyLinkActive = true
                    })
                } else {
                    FavoriteGridView(viewModel: viewModel, onSelect: { whisky in
                        selectedWhisky = whisky
                        isWhiskyLinkActive = true
                    })
                }
            }
            .navigationDestination(isPresented: $isWhiskyLinkActive) {
                if let whisky = selectedWhisky {
                    WhiskyDetailView(whisky: whisky)
                }
            }
        }
        .task {
            await viewModel.fetchWhiskys()
        }
    }
}

#Preview {
    FavoriteTabView().environmentObject(ViewModeSettings())
}
