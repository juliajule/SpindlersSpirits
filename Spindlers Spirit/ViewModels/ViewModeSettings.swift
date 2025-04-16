//
//  ViewModeSettings.swift
//  Spindlers Spirit
//
//  Created by Julia Puhlmann on 16.04.25.
//

import Foundation

class ViewModeSettings: ObservableObject {
    
    enum ViewMode {
        case list
        case grid
    }
    
    @Published var viewMode: ViewMode = .list
}
