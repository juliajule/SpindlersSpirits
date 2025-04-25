//
//  Tasting.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

struct Tasting: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let date: Date
    let imageUrl: String
    let description: String?
    let whiskys: [Whisky]
}

struct MockData {
    
    static let mockTastings: [Tasting] = [
        Tasting(
            id: 2,
            name: "Frühjahrsverkostunggggg",
            date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-10T00:00:00.000+00:00") ?? Date(),
            imageUrl: "images/default_tasting.jpg",
            description: "Ein wärmender Einstieg ins Tasting-Jahr mit rauchigen Noten und Klassikern aus Islay.",
            whiskys: [MockWhiskyData.mockWhiskys[0]]
        ),
        Tasting(
            id: 4,
            name: "Neuter Name",
            date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-14T00:00:00.000+00:00") ?? Date(),
            imageUrl: "images/default_tasting.jpg",
            description: "Ein wärmender Einstieg ins Tasting-Jahr mit rauchigen Noten und Klassikern aus Islay.",
            whiskys: [ Whisky(id: 4, name: "Lagavulin", distillery: "Islay Special", age: 12, alcoholPercentage: 46.0, description: "Smoky and rich", liter:  0.75,
                              price:  12.99,
                              uvp: 10.0,
                              link: "https://www.google.com", imageUrl: ""),
                       Whisky(id: 6, name: "Islay Special", distillery: "Neuer Name", age: 30, alcoholPercentage: 46.0, description: "Smoky and rich", liter:  0.75,
                              price:  12.99,
                              uvp: 10.0,
                              link: "https://www.google.com", imageUrl: ""),
                       Whisky(id: 7, name: "Lagavulin", distillery: "Islay Special autho", age: 12, alcoholPercentage: 46.0, description: "Smoky and rich", liter:  0.75,
                              price:  12.99,
                              uvp: 10.0,
                              link: "https://www.google.com", imageUrl: ""),
                       Whisky(id: 8, name: "Lagavulin", distillery: "Islay Special again autho", age: 12, alcoholPercentage: 46.0, description: "Smoky and rich", liter:  0.75,
                              price:  12.99,
                              uvp: 10.0,
                              link: "https://www.google.com", imageUrl: "")]
        ),
        Tasting(
            id: 5,
            name: "Frühjahrsverkostung 2 auth",
            date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-14T00:00:00.000+00:00") ?? Date(),
            imageUrl: "images/default_tasting.jpg",
            description: "Ein wärmender Einstieg ins Tasting-Jahr mit rauchigen Noten und Klassikern aus Islay.",
            whiskys: []
        )
    ]
}

extension ISO8601DateFormatter {
    static let tastingFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}
