//
//  AllWhiskyTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 19.04.25.
//

import SwiftUI

struct AllWhiskyTabView: View {
    
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @StateObject private var viewModel = WhiskyViewModel()
    @State private var selectedWhisky: Whisky?
    @State private var isWhiskyLinkActive = false
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModeSettings.viewMode == .list {
                    AllWhiskyListView(viewModel: viewModel, onSelect: { whisky in
                        selectedWhisky = whisky
                        isWhiskyLinkActive = true
                    })
                } else {
                    AllWhiskyGridView(viewModel: viewModel, onSelect: { whisky in
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
    AllWhiskyTabView().environmentObject(ViewModeSettings())
}
