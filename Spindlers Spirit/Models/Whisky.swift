//
//  Whisky.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

struct Whisky: Identifiable, Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let distillery: String
    let age: Int
    let alcoholPercentage: Double
    let description: String
    let liter: Double
    let price: Double
    let uvp: Double
    let link: String
    let imageUrl: String
}

struct MockWhiskyData {
    static let mockWhiskys: [Whisky] = [
        Whisky(
            id: 4,
            name: "Lagavulin",
            distillery: "Islay Special",
            age: 12,
            alcoholPercentage: 46.0,
            description: "Smoky and rich",
            liter:  0.75,
            price:  12.99,
            uvp: 10.0,
            link: "https://www.google.com",
            imageUrl: "images/default_whisky.jpg"
        ),
        Whisky(
            id: 6,
            name: "Islay Special",
            distillery: "Neuer Name",
            age: 30,
            alcoholPercentage: 46.0,
            description: "Smoky and rich",
            liter:  0.75,
            price:  12.99,
            uvp: 10.0,
            link: "https://www.google.com",
            imageUrl: ""
        ),
        Whisky(
            id: 7,
            name: "Lagavulin",
            distillery: "Islay Special autho",
            age: 12,
            alcoholPercentage: 46.0,
            description: "Smoky and rich",
            liter:  0.75,
            price:  12.99,
            uvp: 10.0,
            link: "https://www.google.com",
            imageUrl: ""
        ),
        Whisky(
            id: 8,
            name: "Lagavulin",
            distillery: "Islay Special again autho",
            age: 12,
            alcoholPercentage: 46.0,
            description: "Smoky and rich",
            liter:  0.75,
            price:  12.99,
            uvp: 10.0,
            link: "https://www.google.com",
            imageUrl: ""
        )
    ]


}
