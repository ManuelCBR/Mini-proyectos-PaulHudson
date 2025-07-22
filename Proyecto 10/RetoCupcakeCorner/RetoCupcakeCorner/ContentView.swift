//
//  ContentView.swift
//  RetoCupcakeCorner
//
//  Created by Manuel Bermudo on 16/7/25.
//

import SwiftUI

/**
 1 - Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace.         Improve the validation to make sure a string of pure whitespace is invalid.
 2 - If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.
 3 - For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?
 */

struct ContentView: View {
    
    @State private var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    Picker("Elige tu tipo de pastel", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Cantidad: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Extras", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Añade helado", isOn: $order.extraFrosting)
                            
                        Toggle("Añade topping extra", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    NavigationLink("Detalles de envío ") {
                        AdressView(order: order)
                    }
                }
                
            }
            .navigationTitle("Reto Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}

