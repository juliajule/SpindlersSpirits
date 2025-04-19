//
//  TastingTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct TastingTabView: View {

    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @StateObject private var viewModel = TastingViewModel()
    @State private var selectedTasting: Tasting?
    @State private var isLinkActive = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    if viewModeSettings.viewMode == .list {
                        TastingListView(viewModel: viewModel,
                                        onSelect: { tasting in
                            selectedTasting = tasting
                            isLinkActive = true}
                        )
                    } else {
                        TastingGridView(viewModel: viewModel,
                                        onSelect: { tasting in
                            selectedTasting = tasting
                            isLinkActive = true}
                        )
                    }
                }
                .navigationDestination(isPresented: $isLinkActive) {
                    if let tasting = selectedTasting {
                        WhiskyTabView(tasting: tasting)
                    }
                }
            }
            .task {
                await viewModel.fetchTastings()
            }
            .navigationDestination(for: Tasting.self) { tasting in
                WhiskyTabView(tasting: tasting)
            }
        }
    }
}

#Preview {
    TastingTabView().environmentObject(ViewModeSettings())
}
