//
//  Mission.swift
//  RetoMoonShot
//
//  Created by Manuel Bermudo on 31/5/25.
//

import Foundation


struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
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
    
    //Reto 1
    var completeFormattedLaunchDate: String{
        launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A"
    }
}
