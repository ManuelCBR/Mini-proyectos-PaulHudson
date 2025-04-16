//
//  ContentView.swift
//  RetoWordScramble
//
//  Created by Manuel Bermudo on 16/4/25.
//

import SwiftUI

/**
 1. Disallow answers that are shorter than three letters or are just our start word.
 2. Add a toolbar button that calls startGame(), so users can restart with a new word whenever they want to.
 3. Put a text view somewhere so you can track and show the player’s score for a given root word. How you calculate score is down to you, but           something involving number of words and their letter count would be reasonable.
 */

struct ContentView: View {
    
    @State private var useWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var score: Int {
        let letterPoints = useWords.reduce(0) { $0 + $1.count}
        let wordPoints = useWords.count * 2
        return letterPoints + wordPoints
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Introduce tu palabra (en inglés por favor)", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(useWords, id:\.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                                
                        }
                    }
                }
             
                Section{
                    VStack{
                        Text("Tu puntuación es:")
                            .font(.title)
                            .foregroundStyle(Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)))
                        Text("\(score) puntos!")
                            .font(.largeTitle)
                            .foregroundStyle(Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)))
                            .padding(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar { //Reto 2
                Button("Reiniciar") {
                    startGame()
                    useWords.removeAll()
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Palabra repetida", message: "Se más original")
            return
        }
        
        guard isPosible(word: answer) else {
            wordError(title: "Palabra imposible", message: "No puedes deletrear esa palabra de  '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Palabra no reconocida", message: "¡No inventes palabras!")
            return
        }
        
        withAnimation{
            //Reto 1
            if answer.count < 3 {
                wordError(title: "Demasiado corta!", message: "Las palabras deben ser al menos 3 letras")
                showingError = true
            } else if answer.contains(rootWord) {
                wordError(title: "Esfuérzate más!", message: "No puedes presentar la misma palabra que la original")
            } else {
                useWords.insert(answer, at: 0)
            }
        }
        
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            /**
             Se modifica String(contentsOf) añadiendole encoding ya que como está en el tutorial de Paul Hudson
             se deprecará con iOS 18
             */
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        
        fatalError("Couldn't load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !useWords.contains(word)
    }
    
    func isPosible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else { return false }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}

