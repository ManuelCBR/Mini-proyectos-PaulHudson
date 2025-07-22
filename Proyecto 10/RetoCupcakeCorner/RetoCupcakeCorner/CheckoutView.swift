//
//  CheckoutView.swift
//  RetoCupcakeCorner
//
//  Created by Manuel Bermudo on 16/7/25.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var showingError = false //Reto 2
    
    var body: some View {
        ScrollView {
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("El precio es de \(order.cost, format: .currency(code: "EUR"))")
                    .font(.title)
                
                Button("Ordenar pedido") {
                    Task {
                        await placeHolder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Confirmación")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        //Reto 2
        .alert("Error", isPresented: $showingError) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeHolder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Tu pedido de \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) pasteles está en camino!"
            showingConfirmation = true
        } catch {
            print("Error en el pedido: \(error.localizedDescription)")
            
            //Reto 2
            confirmationMessage = "Ha ocurrido un error de conexión, por favor, inténalo de nuevo"
            showingError = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
