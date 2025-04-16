//
//  WhiskyTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import SwiftUI

struct WhiskyTabView: View {

    let tasting: Tasting
    @EnvironmentObject var viewModeSettings: ViewModeSettings
    @StateObject private var viewModel = WhiskyViewModel()
    
    var body: some View {
        Group {
            if viewModeSettings.viewMode == .list {
                WhiskyListView(tasting: tasting, viewModel: viewModel)
            } else {
                WhiskyGridView(tasting: tasting, viewModel: viewModel)
            }
        }
        .task {
            await viewModel.fetchWhiskys(forTastingId: tasting.id)
        }
    }
}

#Preview {
    let sampleTasting = Tasting(
        id: 2,
        name: "Frühjahrsverkostunggggg",
        date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-10T00:00:00.000+00:00") ?? Date(),
        imageUrl: "images/default_tasting.jpg",
        description: "ddddd",
        whiskys: [MockWhiskyData.mockWhiskys[0]]
    )
    WhiskyTabView(tasting: sampleTasting)
        .environmentObject(ViewModeSettings())
}
