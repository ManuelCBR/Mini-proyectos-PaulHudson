//
//  ContentView.swift
//  RetoBetterRest
//
//  Created by Manuel Bermudo on 10/4/25.
//

import CoreML
import SwiftUI

/**
 1. Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout?        It’s your app – you choose!
 2. Replace the “Number of cups” stepper with a Picker showing the same range of values.
 3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “     "Calculate” button entirely.
 */

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = "Select some option"
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components)!
    }
    
    var body: some View {
        NavigationStack{
            Form {
                //Reto 1
                Section("When do you want to wake up?") {
                    DatePicker("Please, enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUp){ //Reto 3
                            calculateBedTime()
                        }
                }
                
                Section("Desired amount of sleep"){
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmount){ //Reto 3
                            calculateBedTime()
                        }
                }
                
                Section("Daily coffee intake"){
                    //Reto 2
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                        ForEach(1..<21){
                            Text("\($0 - 1)")
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: coffeeAmount){ //Reto 3
                        calculateBedTime()
                    }
                }
                
                Section{
                    VStack{
                        Text("Your ideal bed time is")
                            .font(.title)
                            .foregroundStyle(Color(#colorLiteral(red: 0, green: 0.2834590673, blue: 0.6651245952, alpha: 1)))
                        Text(alertMessage)
                            .font(.largeTitle)
                            .foregroundStyle(Color(#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)))
                            .padding(10)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color(#colorLiteral(red: 0.8376609683, green: 0.8433836102, blue: 1, alpha: 1)))
            }
            .navigationTitle("RetoBetterRest")
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = Double(components.hour ?? 0) * 60  * 60
            let minutes = Double(components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
    
}

#Preview {
    ContentView()
}
