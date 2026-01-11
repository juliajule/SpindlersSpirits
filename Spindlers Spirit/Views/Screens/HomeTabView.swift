//
//  HomeTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 07.04.25.
//

import SwiftUI

struct HomeTabView: View {
    
    var body: some View {
        TabView {
            TastingTabView()
                .tabItem {
                    Label("Verkostungen", systemImage: "person.3")
                }
            AllWhiskyTabView()
                .tabItem {
                    Label {
                        Text("Whisky")
                    } icon: {
                        Image("bottle")
                            .renderingMode(.template)
                    }
                }
            SearchTabView()
                .tabItem {
                    Label("Suche", systemImage: "magnifyingglass")
                }
            
            FavoriteTabView()
                .tabItem {
                    Label("Favoriten", systemImage: "heart")
                }
        }
    }
}

#Preview {
    HomeTabView().environmentObject(ViewModeSettings())
}
