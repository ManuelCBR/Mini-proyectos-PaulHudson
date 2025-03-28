//
//  ContentView.swift
//  Reto3ViewsAndModifiers
//
//  Created by Manuel Bermudo on 28/3/25.
//

import SwiftUI

/**
 Create a custom ViewModifier (and accompanying View extension) that makes a view have a large, blue font suitable for prominent titles in a view.
 */

//Reto
//Vista Reto
struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
    }
}

//Extension Reto
extension View {
    func largeBlueFont() -> some View {
        self.modifier(LargeBlueFont())
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
        
    }
    
    var totalAmount: Double {
        return checkAmount + (checkAmount / 100 * Double(tipPercentage))
    }
    
    var body: some View {
        NavigationStack{
            
            VStack{
                Text("ViewsAndModifiers Reto 3")
                    .largeBlueFont()
        
                Form {
                    
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople){
                            ForEach(2..<100){
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section ("How much do you want to tip?"){
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach (0..<101) {
                                Text(($0), format: .percent)
                            }
                        }
                    }
                    
                    Section ("Amount per person"){
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Section ("Total amount"){
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            //Reto
                            .foregroundStyle(tipPercentage == 0 ? Color.red : .primary)
                    }
                }
                .toolbar{
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
           
        }
    }
}

#Preview {
    ContentView()
}
