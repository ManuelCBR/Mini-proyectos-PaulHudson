//
//  AddView.swift
//  RetoNavigationIExpense
//
//  Created by Manuel Bermudo on 22/6/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "Nombre del gasto"
    @State private var type = "Personal"
    @State private var amount: Double = 0.0
    
    var personalExpenses: Expenses
    var businessExpenses: Expenses
    
    let types = ["Negocios", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Tipo", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Cantidad", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name) // Reto 2
            .navigationBarTitleDisplayMode(.inline) // Reto 2
            .toolbar {
                //Reto 1
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancelar"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction){
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
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddView(personalExpenses: Expenses(saveKey: "Personal"), businessExpenses: Expenses(saveKey: "Business"))
}

