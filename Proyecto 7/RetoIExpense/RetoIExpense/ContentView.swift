//
//  ContentView.swift
//  RetoIExpense
//
//  Created by Manuel Bermudo on 8/5/25.
//

import SwiftUI

/**
 1. Use the user’s preferred currency, rather than always using US dollars.
 2. Modify the expense amounts in ContentView to contain some styling depending on their value – expenses under $10 should have one style, expenses under $100 another, and expenses over $100 a third style. What those styles are depend on you.
 3. For a bigger challenge, try splitting the expenses list into two sections: one for personal expenses, and one for business expenses. This is tricky for a few reasons, not least because it means being careful about how items are deleted!
 */

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    private let saveKey: String //Reto 3
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
                //Reto 2
                Section("Gastos Personales"){
                    ForEach(personalExpenses.items) { item in
                        HStack{
                            VStack (alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            //Reto 1
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        }
                        .listRowBackground(defineBackgroundColor(amount: item.amount))
                    }
                    .onDelete(perform: removePersonalItems)
                }
                //Reto 2
                Section("Gastos de Negocio"){
                    ForEach(businessExpenses.items) { item in
                        HStack{
                            VStack (alignment: .leading){
                                Text(item.name)
                                    .font(.headline)
                                
                                Text(item.type)
                            }
                            Spacer()
                            //Reto 1
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        }
                        .listRowBackground(defineBackgroundColor(amount: item.amount))
                    }
                    .onDelete(perform: removeBusinessItems)
                }
                
            }
            .navigationTitle("RetoIExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
            }
        }
    }
    //Reto 3
    func removePersonalItems(at offsets: IndexSet) {
        personalExpenses.items.remove(atOffsets: offsets)
    }
    //Reto 3
    func removeBusinessItems(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)

    }
    
    //Reto 2
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

