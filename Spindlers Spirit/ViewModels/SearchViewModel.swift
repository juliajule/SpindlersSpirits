//
//  SearchViewModel.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 02.05.25.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    
    @Published var query: String = ""
    
    @Published var minAge: Int?
    @Published var maxAge: Int?
    
    @Published var minAlcoholPercentage: Double?
    @Published var maxAlcoholPercentage: Double?
    
    @Published var minPrice: Double?
    @Published var maxPrice: Double?
    
    @Published var tastingDateFrom: Date?
    @Published var tastingDateTo: Date?
    
    @Published var whiskys: [Whisky] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    func formattedDate(_ date: Date?) -> String? {
        guard let date else { return nil }
        return dateFormatter.string(from: date)
    }
    
    func search() async {
        isLoading = true
        errorMessage = nil
        
        let request = WhiskySearchRequest(
            query: query.isEmpty ? nil : query,
            minAge: minAge,
            maxAge: maxAge,
            minAlcoholPercentage: minAlcoholPercentage,
            maxAlcoholPercentage: maxAlcoholPercentage,
            minPrice: minPrice,
            maxPrice: maxPrice,
            tastingDateFrom: formattedDate(tastingDateFrom),
            tastingDateTo: formattedDate(tastingDateTo)
        )
        
        do {
            whiskys = try await APIService.shared.searchWhiskys(request: request)
        } catch let apiError as APIError {
            errorMessage = apiError.localizedDescription
        } catch {
            errorMessage = "Ein unerwarteter Fehler ist aufgetreten."
        }
        
        isLoading = false
    }
    
    func searchAsyncSafe() {
        Task {
            await search()
        }
    }
}
