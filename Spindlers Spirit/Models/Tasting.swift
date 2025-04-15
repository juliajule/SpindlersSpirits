//
//  Tasting.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

struct Tasting: Identifiable, Codable {
    let id: Int
    let name: String
    let date: Date
    let imageUrl: String
    let whiskys: [Whisky]
}

struct MockData {
    static let sampleTastings: [Tasting] = [
        .init(id: 1, name: "Tasting1", date: ISO8601DateFormatter().date(from: "2025-04-10T00:00:00.000+00:00")!, imageUrl: "images/default_tasting.jpg", whiskys: []),
        .init(id: 2, name: "Tasting2", date: ISO8601DateFormatter().date(from: "2025-04-11T00:00:00.000+00:00")!, imageUrl: "images/default_tasting.jpg", whiskys: []),
        .init(id: 3, name: "Tasting3", date: ISO8601DateFormatter().date(from: "2025-04-12T00:00:00.000+00:00")!, imageUrl: "images/default_tasting.jpg", whiskys: []),
    ]
    
    static let mockTastings: [Tasting] = [
        Tasting(
            id: 2,
            name: "Frühjahrsverkostunggggg",
            date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-10T00:00:00.000+00:00") ?? Date(),
            imageUrl: "images/default_tasting.jpg",
            whiskys: [
                Whisky(id: 4, name: "Lagavulin", distillery: "Islay Special", age: 12, alcoholPercentage: 46.0, description: "Smoky and rich", imageUrl: ""),
                Whisky(id: 6, name: "Islay Special", distillery: "Neuer Name", age: 30, alcoholPercentage: 46.0, description: "Smoky and rich", imageUrl: ""),
                Whisky(id: 7, name: "Lagavulin", distillery: "Islay Special autho", age: 12, alcoholPercentage: 46.0, description: "Smoky and rich", imageUrl: ""),
                Whisky(id: 8, name: "Lagavulin", distillery: "Islay Special again autho", age: 12, alcoholPercentage: 46.0, description: "Smoky and rich", imageUrl: "")
            ]
        ),
        Tasting(
            id: 4,
            name: "Neuter Name",
            date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-14T00:00:00.000+00:00") ?? Date(),
            imageUrl: "images/default_tasting.jpg",
            whiskys: []
        ),
        Tasting(
            id: 5,
            name: "Frühjahrsverkostung 2 auth",
            date: ISO8601DateFormatter.tastingFormatter.date(from: "2025-04-14T00:00:00.000+00:00") ?? Date(),
            imageUrl: "images/default_tasting.jpg",
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
