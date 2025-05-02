//
//  SearchTabView.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 28.04.25.
//

import SwiftUI

//struct SearchTabView: View {
//    
//    @StateObject private var viewModel = SearchViewModel()
//    @State private var searchText = ""
//    @State private var selectedWhisky: Whisky?
//    @State private var isWhiskyLinkActive = false
//    @State private var showFilters = false
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 0) {
//                // Header
//                HStack {
//                    Spacer()
//                    Text("Whisky")
//                        .font(.system(size: 28, weight: .bold))
//                    Spacer()
//                }
//                .padding(.top, 12)
//                .padding(.bottom, 8)
//                .background(Color(.systemBackground).shadow(color: Color("Shadows").opacity(0.15), radius: 2, y: 2))
//                
//                // Suchleiste und Filter-Button
//                HStack(spacing: 8) {
//                    TextField("Whiskys durchsuchen...", text: $searchText)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .onChange(of: searchText) { oldValue, newValue in
//                            viewModel.query = newValue
//                            viewModel.searchAsyncSafe()
//                        }
//                    
//                    Button {
//                        withAnimation(.spring(dampingFraction: 0.7)) {
//                            showFilters.toggle()
//                        }
//                    } label: {
//                        Image(systemName: showFilters ? "slider.horizontal.3.fill" : "slider.horizontal.3")
//                            .font(.system(size: 20, weight: .medium))
//                            .foregroundColor(showFilters ? .accentColor : .primary)
//                            .padding(8)
//                            .background(showFilters ? Color(.tertiarySystemFill).opacity(0.7) : Color(.tertiarySystemFill))
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                    }
//                    .accessibilityLabel("Filter anzeigen")
//                }
//                .padding(.horizontal)
//                .padding(.vertical, 8)
//                
//                // Filterpanel
//                if showFilters {
//                    WhiskyFilterPanel(viewModel: viewModel)
//                        .padding(.horizontal)
//                        .transition(.move(edge: .top).combined(with: .opacity))
//                        .zIndex(1)
//                }
//                
//                // Hauptinhalt: Liste, Fehler oder Ladeanzeige
//                Group {
//                    if viewModel.isLoading {
//                        ProgressView("Lade Whiskys...")
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    } else if let error = viewModel.errorMessage {
//                        VStack(spacing: 16) {
//                            Image(systemName: "exclamationmark.triangle")
//                                .font(.system(size: 40))
//                                .foregroundColor(.orange)
//                            
//                            Text(error)
//                                .foregroundColor(.red)
//                                .multilineTextAlignment(.center)
//                            
//                            Button("Erneut versuchen") {
//                                Task {
//                                    await viewModel.search()
//                                }
//                            }
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 10)
//                            .background(Color.accentColor)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                        }
//                        .padding()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    } else {
//                        ScrollView {
//                            LazyVStack(spacing: 16) {
//                                if viewModel.whiskys.isEmpty {
//                                    emptyStateView()
//                                        .padding(.top, 40)
//                                } else {
//                                    ForEach(viewModel.whiskys) { whisky in
//                                        WhiskyRowView(whisky: whisky)
//                                            .onTapGesture {
//                                                selectedWhisky = whisky
//                                                isWhiskyLinkActive = true
//                                            }
//                                    }
//                                    .padding(.bottom, 8)
//                                }
//                            }
//                            .padding(.horizontal)
//                            .padding(.top, 12)
//                        }
//                        .refreshable {
//                            await viewModel.search()
//                        }
//                    }
//                }
//                .animation(.default, value: viewModel.isLoading)
//                .animation(.default, value: viewModel.errorMessage)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//            .navigationDestination(isPresented: $isWhiskyLinkActive) {
//                if let whisky = selectedWhisky {
//                    WhiskyDetailView(whisky: whisky)
//                }
//            }
//        }
//        .task {
//            await viewModel.search()
//        }
//    }
//    
//    @ViewBuilder
//    private func emptyStateView() -> some View {
//        VStack(spacing: 20) {
//            Image("whisky-def") // Stelle sicher, dass dieses Bild existiert
//                .resizable()
//                .scaledToFit()
//                .frame(width: 150, height: 150)
//                .opacity(0.7)
//            
//            if !searchText.isEmpty {
//                Text("Kein Whisky mit \"\(searchText)\" gefunden.")
//                    .font(.headline)
//                    .multilineTextAlignment(.center)
//            } else if showFilters {
//                Text("Keine Treffer mit aktuellen Filtern.")
//                    .font(.headline)
//                    .multilineTextAlignment(.center)
//                
//                Button("Filter zurücksetzen") {
//                    // Diese Methode müsste in deinem WhiskyFilterPanel zugänglich sein
//                    viewModel.minAge = nil
//                    viewModel.maxAge = nil
//                    viewModel.minAlcoholPercentage = nil
//                    viewModel.maxAlcoholPercentage = nil
//                    viewModel.minPrice = nil
//                    viewModel.maxPrice = nil
//                    viewModel.tastingDateFrom = nil
//                    viewModel.tastingDateTo = nil
//                    viewModel.searchAsyncSafe()
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 10)
//                .background(Color.accentColor)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//            } else {
//                Text("Keine Whiskys gefunden.")
//                    .font(.headline)
//                
//                Text("Versuche, einen anderen Suchbegriff einzugeben oder die Filter anzupassen.")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//            }
//        }
//        .padding()
//        .frame(maxWidth: .infinity)
//    }
//}

struct SearchTabView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText = ""
    @State private var selectedWhisky: Whisky?
    @State private var isWhiskyLinkActive = false
    @State private var showFilters = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Text("Whisky")
                        .font(.system(size: 28, weight: .bold))
                    Spacer()
                }
                .padding(.top, 12)
                .padding(.bottom, 8)
                .background(Color(.systemBackground).shadow(color: Color("Shadows").opacity(0.15), radius: 2, y: 2))
                
                // Suchleiste und Filter-Button mit exakt gleicher Größe
                HStack(spacing: 8) {
                    TextField("Whiskys durchsuchen...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: searchText) { oldValue, newValue in
                            viewModel.query = newValue
                            viewModel.searchAsyncSafe()
                        }
                    
                    Button {
                        withAnimation(.spring(dampingFraction: 0.7)) {
                            showFilters.toggle()
                        }
                    } label: {
                        Image(systemName: showFilters ? "slider.horizontal.3.fill" : "slider.horizontal.3")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(showFilters ? .accentColor : .primary)
                            .frame(width: 36, height: 36)
                            .background(showFilters ? Color(.tertiarySystemFill).opacity(0.7) : Color(.tertiarySystemFill))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .accessibilityLabel("Filter anzeigen")
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                ZStack(alignment: .top) {
                    // Hauptinhalt: Leerer Zustand, Liste oder Ladeanzeige
                    Group {
                        if viewModel.isLoading {
                            ProgressView("Lade Whiskys...")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else if let error = viewModel.errorMessage {
                            VStack(spacing: 16) {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.orange)
                                
                                Text(error)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                                
                                Button("Erneut versuchen") {
                                    Task {
                                        await viewModel.search()
                                    }
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else if searchText.isEmpty && !showFilters {
                            // Leerer Zustand, wenn noch keine Suche durchgeführt wurde
                            VStack(spacing: 24) {
                                Image("whisky-def")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .opacity(0.7)
                                
                                Text("Gib einen Suchbegriff ein oder nutze die Filter, um Whiskys zu finden.")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 32)
                            }
                            .padding(.top, 60)
                        } else {
                            ScrollView {
                                if showFilters {
                                    // Platzhalter für das Filter-Panel
                                    Color.clear
                                        .frame(height: 0)
                                }
                                
                                LazyVStack(spacing: 16) {
                                    if viewModel.whiskys.isEmpty {
                                        emptyStateView()
                                            .padding(.top, showFilters ? 250 : 40)
                                    } else {
                                        ForEach(viewModel.whiskys) { whisky in
                                            WhiskyRowView(whisky: whisky)
                                                .onTapGesture {
                                                    selectedWhisky = whisky
                                                    isWhiskyLinkActive = true
                                                }
                                        }
                                        .padding(.bottom, 8)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 12)
                            }
                            .refreshable {
                                await viewModel.search()
                            }
                        }
                    }
                    .animation(.default, value: viewModel.isLoading)
                    .animation(.default, value: viewModel.errorMessage)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    // Filterpanel direkt unter der Suchleiste
                    if showFilters {
                        WhiskyFilterPanel(viewModel: viewModel)
                            .padding(.horizontal)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
            }
            .navigationDestination(isPresented: $isWhiskyLinkActive) {
                if let whisky = selectedWhisky {
                    WhiskyDetailView(whisky: whisky)
                }
            }
        }
        .task {
            // Hier initial keine Suche mehr, da wir erst bei Eingabe suchen wollen
        }
    }
    
    @ViewBuilder
    private func emptyStateView() -> some View {
        VStack(spacing: 20) {
            Image("whisky-def")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .opacity(0.7)
            
            if !searchText.isEmpty {
                Text("Kein Whisky mit \"\(searchText)\" gefunden.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
            } else if showFilters {
                Text("Keine Treffer mit aktuellen Filtern.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                
                Button("Filter zurücksetzen") {
                    viewModel.minAge = nil
                    viewModel.maxAge = nil
                    viewModel.minAlcoholPercentage = nil
                    viewModel.maxAlcoholPercentage = nil
                    viewModel.minPrice = nil
                    viewModel.maxPrice = nil
                    viewModel.tastingDateFrom = nil
                    viewModel.tastingDateTo = nil
                    viewModel.searchAsyncSafe()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    SearchTabView()
}
