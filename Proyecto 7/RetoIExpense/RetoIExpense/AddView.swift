//
//  AddView.swift
//  RetoIExpense
//
//  Created by Manuel Bermudo on 8/5/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount: Double = 0.0
    
    var personalExpenses: Expenses
    var businessExpenses: Expenses
    
    let types = ["Negocios", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
            
                TextField("Nombre", text: $name)

                Picker("Tipo", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Cantidad", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Añade un nuevo gasto")
            .toolbar {
                Button("Guardar"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if type == "Personal" {
                        personalExpenses.items.append(item)
                    } else {
                        businessExpenses.items.append(item)
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView(personalExpenses: Expenses(saveKey: "Personal"), businessExpenses: Expenses(saveKey: "Business"))
}
