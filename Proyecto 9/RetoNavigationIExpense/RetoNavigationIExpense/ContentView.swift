//
//  ContentView.swift
//  RetoNavigationIExpense
//
//  Created by Manuel Bermudo on 22/6/25.
//

import SwiftUI

/**
 1- Change project 7 (iExpense) so that it uses NavigationLink for adding new expenses rather than a sheet. (Tip: The dismiss() code works great here, but you might want to add the navigationBarBackButtonHidden() modifier so they have to explicitly choose Cancel.)
 2- Try changing project 7 so that it lets users edit their issue name in the navigation title rather than a separate textfield. Which option do you prefer?
 */

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    private let saveKey: String
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: saveKey)
            }
        }
    }
    init(saveKey: String) {
        self.saveKey = saveKey
        if let savedItems = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decoded
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var personalExpenses = Expenses(saveKey: "PersonalItem")
    @State private var businessExpenses = Expenses(saveKey: "BusinessItem")
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Gastos Personales"){
                    ForEach(personalExpenses.items) { item in
                        HStack{
                            VStack (alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        }
                        .listRowBackground(defineBackgroundColor(amount: item.amount))
                    }
                    .onDelete(perform: removePersonalItems)
                }
                Section("Gastos de Negocio"){
                    ForEach(businessExpenses.items) { item in
                        HStack{
                            VStack (alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        }
                        .listRowBackground(defineBackgroundColor(amount: item.amount))
                    }
                    .onDelete(perform: removeBusinessItems)
                }
                
            }
            .navigationTitle("Reto Navigation 1 y 2")
            .toolbar {
                //Reto 1
                NavigationLink{
                    AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
                }label:{
                    Button("Add Expense", systemImage: "plus"){
                        showingAddExpense = true
                    }
                }
                
            }
        }
    }
    func removePersonalItems(at offsets: IndexSet) {
        personalExpenses.items.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)

    }
    
    func defineBackgroundColor(amount: Double) -> Color {
        switch amount {
        case ...10:
            return Color.green.opacity(0.2)
        case 11..<100:
            return Color.yellow.opacity(0.2)
        case 99...:
            return Color.red.opacity(0.2)
        default:
            return Color.gray
        }
    }
}

#Preview {
    ContentView()
}

