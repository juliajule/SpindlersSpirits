//
//  Whisky.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 13.04.25.
//

import Foundation

struct Whisky: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let distillery: String
    let age: Int
    let alcoholPercentage: Double
    let description: String
    let imageUrl: String
}
