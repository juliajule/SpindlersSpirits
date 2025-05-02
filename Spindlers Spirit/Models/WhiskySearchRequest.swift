//
//  WhiskySearchRequest.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 01.05.25.
//

import Foundation

struct WhiskySearchRequest: Encodable {
    var query: String?
    var minAge: Int?
    var maxAge: Int?
    var minAlcoholPercentage: Double?
    var maxAlcoholPercentage: Double?
    var minPrice: Double?
    var maxPrice: Double?
    var tastingDateFrom: String?
    var tastingDateTo: String?
}
