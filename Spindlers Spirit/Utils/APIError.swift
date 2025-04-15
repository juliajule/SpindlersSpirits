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
    case noInternet
    case timeout
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Die Serveradresse ist ungültig."
        case .invalidResponse:
            return "Die Antwort vom Server war ungültig."
        case .decodingError:
            return "Die Daten konnten nicht verarbeitet werden."
        case .serverError(let code):
            return "Der Server hat mit Fehler \(code) geantwortet."
        case .noInternet:
            return "Keine Internetverbindung. Bitte überprüfe deine Verbindung."
        case .timeout:
            return "Die Anfrage hat zu lange gedauert. Bitte versuche es später erneut."
        case .unknown:
            return "Ein unbekannter Fehler ist aufgetreten."
        }
    }
}
