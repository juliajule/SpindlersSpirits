//
//  APIService.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

class APIService {
    static let shared = APIService()

    func fetchTastings() async throws -> [Tasting] {
        guard let url = URL(string: "\(AppConfig.baseURL)/tastings") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(AppConfig.appVersion, forHTTPHeaderField: "X-App-Version")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            print("Statuscode:", httpResponse.statusCode)
            throw APIError.serverError(code: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode([Tasting].self, from: data)
        } catch {
            print("Fehler beim Decodieren:", error)
            print("Antwort als String:", String(data: data, encoding: .utf8) ?? "n/a")
            throw APIError.decodingError
        }
    }

    func fetchWhiskys() async throws -> [Whisky] {
        guard let url = URL(string: "\(AppConfig.baseURL)/whiskys") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(AppConfig.appVersion, forHTTPHeaderField: "X-App-Version")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            print("Statuscode:", httpResponse.statusCode)
            throw APIError.serverError(code: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode([Whisky].self, from: data)
        } catch {
            print("Fehler beim Decodieren:", error)
            print("Antwort als String:", String(data: data, encoding: .utf8) ?? "n/a")
            throw APIError.decodingError
        }
    }
}
