//
//  WhiskyViewModel.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import Foundation

@MainActor
class WhiskyViewModel: ObservableObject {
    
    @Published var whiskys: [Whisky] = []
    @Published var tasting: Tasting?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchWhiskys() async {
        isLoading = true
        errorMessage = nil
        do {
            whiskys = try await APIService.shared.fetchWhiskys()
        } catch let apiError as APIError {
            errorMessage = apiError.localizedDescription
            print("Fehler beim Laden der Whiskys: \(apiError)")
        } catch {
            errorMessage = "Ein unerwarteter Fehler ist aufgetreten."
            print("Unbekannter Fehler beim Laden der Whiskys: \(error)")
        }
        isLoading = false
    }
    
    func fetchWhiskys(forTastingId id: Int) async {
        isLoading = true
        errorMessage = nil
        do {
            let tastingDetail = try await APIService.shared.fetchTastingDetail(id: id)
            self.tasting = tastingDetail
            self.whiskys = tastingDetail.whiskys
        } catch let apiError as APIError {
            errorMessage = apiError.localizedDescription
        } catch {
            errorMessage = "Ein unerwarteter Fehler ist aufgetreten."
        }
        isLoading = false
    }
}
