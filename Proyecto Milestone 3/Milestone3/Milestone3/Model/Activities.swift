//
//  Activities.swift
//  Milestone3
//
//  Created by Manuel Bermudo on 3/7/25.
//

import Foundation

@Observable
class Activities {
    var activities = [Activity](){
        didSet{
            if let encoded = try? JSONEncoder().encode(activities){
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
    }
    init(){
        if let savedActivites = UserDefaults.standard.data(forKey: "activities"){
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivites){
                activities = decodedActivities
                return
            }
        }
        activities = []
    }
}
