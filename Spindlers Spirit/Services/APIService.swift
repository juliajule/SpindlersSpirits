//
//  APIService.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let baseURL = "http://localhost:8080" 

    func fetchTastings() async throws -> [Tasting] {
        guard let url = URL(string: "\(baseURL)/tastings") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Tasting].self, from: data)
    }

    func fetchWhiskys() async throws -> [Whisky] {
        guard let url = URL(string: "\(baseURL)/whiskys") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Whisky].self, from: data)
    }
}
