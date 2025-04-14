//
//  TastingListViewModel.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

@MainActor
class TastingListViewModel: ObservableObject {
    
    @Published var tastings: [Tasting] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchTastings() async {
        isLoading = true
        errorMessage = nil
        do {
            tastings = try await APIService.shared.fetchTastings()
        } catch {
            errorMessage = "Daten konnten nicht geladen werden."
            print("Fehler beim Laden: \(error)")
        }
        isLoading = false
    }
}
