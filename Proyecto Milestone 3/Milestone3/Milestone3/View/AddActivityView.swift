//
//  AddActivityView.swift
//  Milestone3
//
//  Created by Manuel Bermudo on 3/7/25.
//

import SwiftUI

struct AddActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var activities: Activities
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Nombre", text: $name)
                    .listRowBackground(Color.card)
                TextField("Descripción", text: $description)
                    .listRowBackground(Color.card)
                    
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Añade tu actividad")
            .toolbar{
                Button("Guardar"){
                    let activity = Activity(name: name, description: description)
                    activities.activities.append(activity)
                    dismiss()
                }
                .foregroundStyle(Color.secondaryCard)
            }
            .background(Color.primaryBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}

