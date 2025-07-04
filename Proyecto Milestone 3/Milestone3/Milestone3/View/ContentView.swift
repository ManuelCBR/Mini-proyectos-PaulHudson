//
//  ContentView.swift
//  Milestone3
//
//  Created by Manuel Bermudo on 3/7/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(activities.activities){activity in
                        NavigationLink{
                            DescriptionActivityView(activities: activities, descriptions: activity)
                        }label:{
                            HStack{
                                Text(activity.name)
                                    .font(.headline)
                                Image(systemName: "\(activity.completionCount).circle")
                                    .padding(.leading, 30)
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: removeActivities)
                }
                .toolbarBackground(Color.card)
                .navigationTitle("Actividades")
                .toolbar{
                    Button(action: {
                        showingAddActivity = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color.secondaryCard)
                    }
                }
                .listStyle(.plain)
                .sheet(isPresented: $showingAddActivity, content: {
                    AddActivityView(activities: activities)
                })
            }
            .background(Color.primaryBackground)
            .preferredColorScheme(.dark)
        }
    }
    func removeActivities (at offsets: IndexSet){
        activities.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

