//
//  Activity.swift
//  Milestone3
//
//  Created by Manuel Bermudo on 3/7/25.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    var completionCount: Int = 1
}
