//
//  TastingListView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import SwiftUI

struct TastingListView: View {
    
    @StateObject private var viewModel = TastingListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Lade Tastings...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else if viewModel.tastings.isEmpty {
                    EmptyStateView(imageName: "whisky-def", message: "Keine Tastings gefunden.")
                } else {
                   // NavigationStack {
                     //   List(viewModel.tastings) { tasting in
                       //     NavigationLink(destination: Text("Detailansicht für \(tasting.name)")) {
                         //       TastingRowView(tasting: tasting)
                           // }
                            //.listRowSeparator(.hidden)
                        //}
                       // .navigationTitle("Verkostungen")
                       // .listStyle(PlainListStyle())
                    
                    //}
                    NavigationStack {
                        VStack(spacing: 0) {
                            // Eigener Header
                            HStack {
                                Spacer()
                                Text("Verkostungen")
                                    .font(.system(size: 28, weight: .bold))
                                Spacer()
                                Button {
                                    print("Grid View tapped")
                                } label: {
                                    Image(systemName: "square.grid.2x2")
                                        .imageScale(.large)
                                        .padding(.trailing)
                                }
                            }
                            .padding(.vertical, 16)
                            .background(Color(.systemBackground).shadow(color: Color.black.opacity(0.05), radius: 1, y: 2))
                            
                            // Liste
                            ScrollView {
                                VStack(spacing: 12) {
                                    ForEach(viewModel.tastings) { tasting in
                                        TastingRowView(tasting: tasting)
                                            .onTapGesture {
                                                // später Detailansicht
                                            }
                                    }
                                    .padding(.horizontal)
                                }
                                .padding(.top, 8)
                            }
                        }
                        //.background(Color(.systemGroupedBackground))
                    }
                }
            }
        }
        .task {
            await viewModel.fetchTastings()
        }
    }
}

#Preview {
    TastingListView()
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
