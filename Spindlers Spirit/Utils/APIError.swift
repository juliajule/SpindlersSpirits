//
//  APIError.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(code: Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Ungültige URL"
        case .invalidResponse:
            return "Ungültige Serverantwort"
        case .decodingError:
            return "Antwort konnte nicht verarbeitet werden"
        case .serverError(let code):
            return "Serverfehler mit Code \(code)"
        case .unknown:
            return "Unbekannter Fehler"
        }
    }
}
