//
//  ContentView.swift
//  RetoNavigationMoonShot
//
//  Created by Manuel Bermudo on 22/6/25.
//

import SwiftUI

/**
 3- Return to project 8 (Moonshot), and upgrade it to use NavigationLink(value:). This means adding Hashable conformance, and thinking carefully how to use navigationDestination().
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
