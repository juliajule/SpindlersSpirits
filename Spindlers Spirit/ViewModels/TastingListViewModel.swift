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
    @Published var isGridView: Bool = false

    func fetchTastings() async {
        isLoading = true
        errorMessage = nil
        do {
            tastings = try await APIService.shared.fetchTastings().sorted { $0.date > $1.date }
        } catch let apiError as APIError {
            errorMessage = apiError.localizedDescription
            print("Fehler beim Laden: \(apiError)")
        } catch {
            //errorMessage = error.localizedDescription
            errorMessage = "Ein unerwarteter Fehler ist aufgetreten."
            print("Unbekannter Fehler beim Laden: \(error)")
        }
        isLoading = false
    }
}
