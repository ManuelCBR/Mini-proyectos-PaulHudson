//
//  ContentView.swift
//  Reto2ViewsAndModifiers
//
//  Created by Manuel Bermudo on 28/3/25.
//

import SwiftUI

/**
 Go back to project 2 and replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers
 */

//Reto
struct FlagImage: View {
    
    var image: String
    
    var body: some View {

        Image(image)
            .clipShape(.rect(cornerRadius: 20))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0

    @State private var counterQuestion = 1
    @State private var showingFinalScoreAlert = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 2), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("ViewsAndModifiers Reto 2")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
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
                        } label: {
                            //Reto
                            FlagImage(image: countries[number])
                        }
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
            Text("Your score is \(score) of 8") //Reto 1
        }
        .alert(scoreTitle, isPresented: $showingFinalScoreAlert){
            Button("Reset", action: resetGame)
        } message: {
            Text("Your final score is \(score) of 8") //Reto 3
        }
    }
    
    func flagTapped(_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }else {
            //Reto 2
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
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = 0
        counterQuestion = 1
        askQuestion()
    }
}

#Preview {
    ContentView()
}
