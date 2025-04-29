//
//  SearchTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 28.04.25.
//

import SwiftUI

struct SearchTabView: View {
    
     @StateObject private var viewModel = WhiskyViewModel()
     @State private var searchText = ""
     @State private var selectedWhisky: Whisky?
     @State private var isWhiskyLinkActive = false

     var filteredWhiskys: [Whisky] {
         if searchText.isEmpty {
             return []
         } else {
             return viewModel.whiskys.filter { whisky in
                 whisky.name.localizedCaseInsensitiveContains(searchText)
             }
         }
     }
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Text("Whisky")
                            .font(.system(size: 28, weight: .bold))
                        Spacer()
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 8)
                    .background(Color(.systemBackground).shadow(color: Color("Shadows").opacity(0.15), radius: 2, y: 2))
                }

                TextField("Whiskys durchsuchen...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                Group {
                    if viewModel.isLoading {
                        ProgressView("Lade Whiskys...")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                if filteredWhiskys.isEmpty && !searchText.isEmpty {
                                    EmptyStateView(imageName: "whisky-def", message: "Kein Whisky gefunden.")
                                        .padding()
                                } else {
                                    ForEach(filteredWhiskys) { whisky in
                                        WhiskyRowView(whisky: whisky)
                                            .onTapGesture {
                                                selectedWhisky = whisky
                                                isWhiskyLinkActive = true
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 12)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    SearchTabView()
}
