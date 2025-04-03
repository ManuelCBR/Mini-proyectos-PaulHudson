//
//  ContentView.swift
//  Milestone 1
//
//  Created by Manuel Bermudo on 3/4/25.
//

import SwiftUI
/**
 - Each turn of the game the app will randomly pick either rock, paper, or scissors.
 - Each turn the app will alternate between prompting the player to win or lose.
 - The player must then tap the correct move to win or lose the game.
 - If they are correct they score a point; otherwise they lose a point.
 - The game ends after 10 questions, at which point their score is shown.
 So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
 */
struct ContentView: View {
    
    @State private var optionsGame = ["👊🏼Rock    ", "🤚🏼Paper   ", "✌🏼Scissors"]
    @State private var currentPlayerChoice = ""
    @State private var currentRandomChoice = Int.random(in: 0...2)
    @State private var win = false
    @State private var result = "Result"
    @State private var emoji = ""
    @State private var showingAlert = false
    @State private var counterScore = 0
    @State private var counterWin = 0
    
    
    var winOrLose: String {win == true ? "You Win!" : "You Lose!"}
    
    var body: some View {
        
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                VStack(alignment: .center){
                    Text("Choose your option!")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                }
                Spacer()
                Text(emoji)
                    .font(.custom(emoji, size: 60))
                    .foregroundStyle(.white)
                    .frame(width: 300, height: 300)
                    .background(.orange)
                    .clipShape(.circle)
                    .cornerRadius(10)
                Spacer()
                Text(result)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 350, height: 150)
                    .background(.blue)
                    .clipShape(.capsule)
                Text(winOrLose)
                    .foregroundStyle(.white)
                    .font(.title)
                Spacer()
                Spacer()
                HStack{
                    
                    ForEach(0..<3){number in
                        Button{
                            game(number: number)
                        }label: {
                            Text("\(optionsGame[number])")
                                .padding()
                                .background(.blue)
                                .clipShape(.capsule)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(10)
                Spacer()
            }
            .alert("Game Over", isPresented: $showingAlert) {
                Button("Restart") {
                    counterScore = 0
                    counterWin = 0
                    result = "Result"
                
                }
            }message: {
                Text("Your final score is \(counterWin) Wins of 10 games")
            }
        }
    }
    func game (number: Int){
    
        currentPlayerChoice = optionsGame[number]
        currentRandomChoice = Int.random(in: 0...2)
                
        if number == currentRandomChoice {
            result = "It`s a tie! you chose \(optionsGame[number]) and the opponent chose \(optionsGame[currentRandomChoice])"
            emoji = optionsGame[currentRandomChoice]
            counterScore += 1
        } else if (number == 0 && currentRandomChoice == 2) ||
            (number == 1 && currentRandomChoice == 0) ||
            (number == 2 && currentRandomChoice == 1) {
            win = true
            result = "You chose \(optionsGame[number]) and the opponent chose \(optionsGame[currentRandomChoice])"
            emoji = optionsGame[currentRandomChoice]
            counterScore += 1
            counterWin += 1
        } else {
            win = false
            result = "You chose \(optionsGame[number]) and the opponent chose \(optionsGame[currentRandomChoice])"
            emoji = optionsGame[currentRandomChoice]
            counterScore += 1
            counterWin += 1
        }
        if counterScore == 10 {
            showingAlert = true
        } else {
            showingAlert = false
        }

                
    }
}

#Preview {
    ContentView()
}
