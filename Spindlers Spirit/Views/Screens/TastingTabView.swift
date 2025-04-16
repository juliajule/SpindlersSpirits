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
    
    var body: some View {
        Group {
            if viewModeSettings.viewMode == .list {
                TastingListView(viewModel: viewModel)
            } else {
                TastingGridView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.fetchTastings()
        }
    }
}

#Preview {
    TastingTabView().environmentObject(ViewModeSettings())
}
