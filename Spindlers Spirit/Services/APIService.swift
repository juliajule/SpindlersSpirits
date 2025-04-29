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
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            decoder.dateDecodingStrategy = .formatted(formatter)
            return try decoder.decode([Tasting].self, from: data)
            
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                throw APIError.noInternet
            case .timedOut:
                throw APIError.timeout
            default:
                print("URLError:", urlError)
                throw APIError.unknown
            }
        } catch {
            print("Fehler beim Decodieren oder anderen Fehler:", error)
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
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                throw APIError.noInternet
            case .timedOut:
                throw APIError.timeout
            default:
                throw APIError.unknown
            }
        } catch {
            print("Fehler beim Decodieren oder anderen Fehler:", error)
            print("Antwort als String:", String(data: data, encoding: .utf8) ?? "n/a")
            throw APIError.decodingError
        }
    }
    
    func fetchTastingDetail(id: Int) async throws -> Tasting {
        guard let url = URL(string: "\(AppConfig.baseURL)/tastings/\(id)") else {
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
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            decoder.dateDecodingStrategy = .formatted(formatter)
            return try decoder.decode(Tasting.self, from: data)

        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                throw APIError.noInternet
            case .timedOut:
                throw APIError.timeout
            default:
                throw APIError.unknown
            }
        } catch {
            print("Fehler beim Decodieren:", error)
            print("Antwort als String:", String(data: data, encoding: .utf8) ?? "n/a")
            throw APIError.decodingError
        }
    }
    
    func searchWhiskys(query: String) async throws -> [Whisky] {
        guard let url = URL(string: "\(AppConfig.baseURL)/whiskys/search?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
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
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                throw APIError.noInternet
            case .timedOut:
                throw APIError.timeout
            default:
                throw APIError.unknown
            }
        } catch {
            print("Fehler beim Decodieren oder anderen Fehler:", error)
            print("Antwort als String:", String(data: data, encoding: .utf8) ?? "n/a")
            throw APIError.decodingError
        }
    }
}
