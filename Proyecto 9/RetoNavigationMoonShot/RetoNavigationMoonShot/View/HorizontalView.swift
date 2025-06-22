//
//  HorizontalView.swift
//  RetoNavigationMoonShot
//
//  Created by Manuel Bermudo on 22/6/25.
//

import SwiftUI

struct HorizontalView: View {
    
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height: 72)
                            .clipShape(.capsule)
                            .overlay(
                                Capsule()
                                    .strokeBorder(.white, lineWidth: 1)
                            )
                        VStack(alignment: .leading){
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    HorizontalView(crew: [
        MissionView.CrewMember(
            role: "Commander",
            astronaut: Astronaut(
                id: "armstrong",
                name: "Neil Armstrong",
                description: "First person to walk on the moon."
            )
        ),
        MissionView.CrewMember(
            role: "Pilot",
            astronaut: Astronaut(
                id: "aldrin",
                name: "Buzz Aldrin",
                description: "Piloted the Lunar Module."
            )
        )
    ])
    .preferredColorScheme(.dark)
}
