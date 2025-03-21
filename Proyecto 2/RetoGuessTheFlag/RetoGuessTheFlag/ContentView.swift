//
//  ContentView.swift
//  RetoGuessTheFlag
//
//  Created by Manuel Bermudo on 17/3/25.
//

import SwiftUI

/*
1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
2. When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
3. Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
 
 TERMINAR LA NUMERO 3
*/

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    //Reto 1
    @State private var score = 0
    //Reto 3
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
                Text("Guess the flag")
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
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(radius: 5)
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
