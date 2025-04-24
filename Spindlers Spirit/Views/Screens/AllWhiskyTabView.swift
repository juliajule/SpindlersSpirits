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
    
    var body: some View {
        VStack(spacing: 0) {
            if viewModeSettings.viewMode == .list {
                AllWhiskyListView(viewModel: viewModel)
            } else {
                AllWhiskyGridView(viewModel: viewModel)
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
