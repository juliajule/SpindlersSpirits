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
            TastingListView()
                .tabItem {
                    Label("Verkostungen", systemImage: "person.3")
                }
            Text("whisky")
                .tabItem {
                    Label {
                        Text("Whisky")
                    } icon: {
                        Image("bottle")
                            .renderingMode(.template)
                    }
                }
            Text("fav")
                .tabItem {
                    Label("Favoriten", systemImage: "heart")
                }
            Text("search")
                .tabItem {
                    Label("Suche", systemImage: "magnifyingglass")
                }
        }
    }
}

#Preview {
    HomeTabView()
}
