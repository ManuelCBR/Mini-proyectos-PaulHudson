//
//  ContentView.swift
//  Animations
//
//  Created by Manuel Bermudo on 22/4/25.
//

import SwiftUI

/**
 Challenge
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on.
 Go back to the Guess the Flag project and add some animation:
 - 1. When you tap a flag, make it spin around 360 degrees on the Y axis.
 - 2.  Make the other two buttons fade out to 25% opacity.
 - 3. Add a third effect of your choosing to the two flags the user didn’t choose – maybe make them scale down? Or flip in a different direction? Experiment!
 */

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0

    @State private var counterQuestion = 1
    @State private var showingFinalScoreAlert = false
    
    @State private var animationAmount3D = [0.0, 0.0, 0.0]
    @State var selectedFlag: Int? = nil
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Reto Animations")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 30) {
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            //Reto 1
                            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                                animationAmount3D[number] += 360
                            }
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(radius: 5)
                        }
                        //Reto 1
                        .rotation3DEffect(.degrees(animationAmount3D[number]), axis: (x: 1.0, y: 0.0, z: 0.0))
                        //Reto 2
                        .opacity(selectedFlag == nil || selectedFlag == number ? 1 : 0.25)
                        //Reto 3
                        .scaleEffect(selectedFlag == nil || selectedFlag == number ? 1 : 0.65)
                        .animation(.easeInOut(duration: 0.5), value: selectedFlag)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)/\(counterQuestion - 1)")
                    .font(.title.bold())
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.regularMaterial)
                    )

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score) of 8")
        }
        .alert(scoreTitle, isPresented: $showingFinalScoreAlert){
            Button("Reset", action: resetGame)
        } message: {
            Text("Your final score is \(score) of 8")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        selectedFlag = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }else {
            scoreTitle = "Wrong, That's the flag of \(countries[number])"
        }
        
        if counterQuestion == 8 {
            showingFinalScoreAlert = true
            scoreTitle = "Finished!!"
        } else {
            showingScore = true
        }
        counterQuestion += 1
    }
    
    func askQuestion() {
        selectedFlag = nil
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        selectedFlag = nil
        score = 0
        counterQuestion = 1
        askQuestion()
    }
}

#Preview {
    ContentView()
}
