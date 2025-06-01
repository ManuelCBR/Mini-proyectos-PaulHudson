//
//  ContentView.swift
//  RetoMoonShot
//
//  Created by Manuel Bermudo on 31/5/25.
//

import SwiftUI

/**
 1. Add the launch date to MissionView, below the mission badge. You might choose to format this differently given that more space is available, but it’s down to you.
 2. Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.
 3. For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.
 */

struct ContentView: View {
    
    @State var toggleButton = "List"
    @State var showingGrid = true
    
    var body: some View {
        NavigationStack{
            Group {
                if showingGrid {
                    MissionGridView()
                } else {
                    MissionListView()
                }
            }
            .preferredColorScheme(.dark)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        withAnimation {
                            showingGrid.toggle()
                        }
                    }) {
                        Image (systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
