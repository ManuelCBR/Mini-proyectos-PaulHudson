//
//  MissionListView.swift
//  RetoMoonShot
//
//  Created by Manuel Bermudo on 1/6/25.
//

import SwiftUI

struct MissionListView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack{
                List(missions){mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    }label:{
                        HStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            VStack{
                                Text(mission.displayName)
                                    .font(.title3.bold())
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                .background(.darkBackground)
            }
            .navigationTitle("Moonshot")
        }
    }
}

#Preview {
    MissionListView()
        .preferredColorScheme(.dark)
}
