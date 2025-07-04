//
//  DescriptionActivityView.swift
//  Milestone3
//
//  Created by Manuel Bermudo on 3/7/25.
//

import SwiftUI

struct DescriptionActivityView: View {
    
    var activities: Activities
    
    var descriptions: Activity
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Text("\(descriptions.description)")
                        .font(.title2)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                    Spacer()
                }
                Spacer()
                VStack(alignment: .center){
                    Text("Completada \(descriptions.completionCount) veces")
                        .font(.title2)
                    Button(action: {
                        incrementActivityCount()
                    }, label: {
                        Text("Añade esta tarea una vez más")
                            .foregroundStyle(.white)
                        Spacer()
                            .frame(width: 20)
                        Image(systemName: "plus")
                            .clipShape(Circle())
                            .foregroundStyle(Color.secondaryCard)
                    })
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.card)
                            .shadow(radius: 5)
                    )
                    Spacer()
                        .frame(height: 30)
                }
            }
            .background(Color.primaryBackground)
            .navigationTitle("\(descriptions.name)")
            .preferredColorScheme(.dark)
        }
    }
    func incrementActivityCount() {
            if let index = activities.activities.firstIndex(of: descriptions) {
                var newActivity = descriptions
                newActivity.completionCount += 1
                activities.activities[index] = newActivity
            }
        }
}

#Preview {
    let descriptionActivity = Activity(name: "Actividad 1", description: "Descripción 1")
    return DescriptionActivityView(activities: Activities(), descriptions: descriptionActivity)
}
