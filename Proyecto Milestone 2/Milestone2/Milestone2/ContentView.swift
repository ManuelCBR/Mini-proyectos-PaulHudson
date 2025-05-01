//
//  ContentView.swift
//  Milestone2
//
//  Created by Manuel Bermudo on 1/5/25.
//

import SwiftUI

/**
 Your goal is to build an “edutainment” app for kids to help them practice multiplication tables – “what is 7 x 8?” and so on. Edutainment apps are educational at their core, but ideally have enough playfulness about them to make kids want to play.

 Breaking it down:
 - 1. The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
 - 2. The player should be able to select how many questions they want to be asked: 5, 10, or 20.
 - 3. You should randomly generate as many questions as they asked for, within the difficulty range they asked for.
 */

struct Question {
    let question: String
    let answer: Int
    let options: [Int]
}

struct ContentView: View {
    
    @State private var numMultiTable = 2
    @State private var numOfQuestions = 5
    @State private var questionNumber = 0
    @State private var isStarted = false
    @State private var questions = [Question]()
    @State private var currentQuestionIndex = 0
    @State private var showingResult = false
    @State private var showingError = false
    
    @State private var animationAmount = 1
    @State private var isAnimating = true
    @State private var imageOffset: CGFloat = 0
    @State private var scaleEffect: CGFloat = 1
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(colors: [Color(#colorLiteral(red: 0.4501125216, green: 0.9813063741, blue: 0.4743013978, alpha: 1)), Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack{
                    Spacer()
                    if isStarted {
                        
                        Text(questions[currentQuestionIndex].question)
                            .font(.largeTitle)
                            .padding()
                        
                        ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                            Button(action: {
                                checkAnswer(selectedAnswer: option)
                            }) {
                                Text("\(option)")
                                    .foregroundColor(.black)
                                    .bold()
                                    .font(.title2)
                                    .frame(width: 200, height: 50)
                                    .background(.yellow)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(5)
                            }
                        }
                    }else{
                        Text("Multiplications tables for kids!")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(Color(#colorLiteral(red: 0.251683712, green: 0.4673525691, blue: 0.2600500286, alpha: 1)))
                        Spacer()
                            .frame(height: 20)
                        Form{
                            Section ("Choose the multiplication table"){
                                Stepper("Table number \(numMultiTable)", value: $numMultiTable, in: 2...12)
                                    .font(.title3 )
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color(#colorLiteral(red: 0.8320752978, green: 0.9834622741, blue: 0.2546361089, alpha: 1)))
                                    .clipShape(.rect(cornerRadius: 10))
                                
                            }
                            .listRowBackground(Color.clear)
                            Section("Number of questions"){
                                
                                Picker ("Number of questions", selection: $numOfQuestions){
                                    Text("5").tag(5)
                                    Text("10").tag(10)
                                    Text("20").tag(20)
                                }
                                .listRowBackground(Color.clear)
                                .background(.green)
                                .clipShape(.rect(cornerRadius: 10))
                                .pickerStyle(.segmented)
                                .onAppear {
                                    UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.yellow
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        
                        Spacer()
                            .frame(height: 50)
                        Image("giraffe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .offset(y: imageOffset)
                            .scaleEffect(scaleEffect)
                            .onAppear {
                                withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                    imageOffset = -30
                                    scaleEffect = 1
                                }
                            }
                        VStack{
                            Spacer()
                            
                            Button{
                                startGame()
                            }label: {
                                HStack{
                                    Spacer()
                                    Image("duck")
                                    Spacer()
                                        .frame(width: 20)
                                    Text("Start game!")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.title2)
                                    Spacer()
                                        .frame(width: 50)
                                }
                                .frame(width: 300, height: 80)
                                .background(.yellow)
                                .clipShape(.rect(cornerRadius: 10))
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .navigationBarItems(leading: isStarted ? AnyView(Button(action: {
                    isStarted = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                        Text("Back")
                            .foregroundStyle(.black)
                    }
                }) : AnyView(EmptyView()))
                    .navigationBarTitle("", displayMode: .inline)
            }
            .alert("Good job! \n You completed all the questions.", isPresented: $showingResult) {
                Button("OK"){isStarted = false}
            }
            .alert("You answer is wrong", isPresented: $showingError) {
                Text("Try again")
            }
        }
    }
    func startGame (){
        currentQuestionIndex = 0
        questions = []
        questions = generateQuestions()
        isStarted = true
    }
    func generateQuestions () -> [Question]{
        var allQuestions = [Question]()
        
        for num in 1...12 {
            let questionText = "\(numMultiTable) x \(num) is"
            let answer = numMultiTable * num
            let options = generateOptions(correctAnswer: answer)
            let question = Question(question: questionText, answer: answer, options: options)
            allQuestions.append(question)
        }
        allQuestions.shuffle()
        return Array(allQuestions.prefix(numOfQuestions))
    }
    func generateOptions(correctAnswer: Int) -> [Int] {
            var options = [correctAnswer]
            while options.count < 4 {
                let randomOption = Int.random(in: 1...numMultiTable * 12)
                if !options.contains(randomOption) {
                    options.append(randomOption)
                }
            }
            return options.shuffled()
    }
    func checkAnswer(selectedAnswer: Int) {
            let currentQuestion = questions[currentQuestionIndex]
        if selectedAnswer == currentQuestion.answer {
            if currentQuestionIndex == questions.count - 1 {
                showingResult = true
            }else{
                currentQuestionIndex += 1
            }
        }else{
            showingError = true
        }
    }
}

#Preview {
    ContentView()
}
