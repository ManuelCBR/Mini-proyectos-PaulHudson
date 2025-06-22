//
//  Mission.swift
//  RetoNavigationMoonShot
//
//  Created by Manuel Bermudo on 22/6/25.
//

import Foundation
//Se conforma el protocolo Hashable para el reto 3
struct Mission: Codable, Identifiable, Hashable{
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var completeFormattedLaunchDate: String{
        launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A"
    }
}
