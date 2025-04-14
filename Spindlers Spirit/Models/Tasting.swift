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
    let date: String
    let imageUrl: String
    let whiskys: [Whisky]
}
