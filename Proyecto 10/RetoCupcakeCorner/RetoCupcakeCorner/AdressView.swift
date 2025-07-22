//
//  AdressView.swift
//  RetoCupcakeCorner
//
//  Created by Manuel Bermudo on 16/7/25.
//

import SwiftUI

struct AdressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Nombre", text: $order.name)
                TextField("Calle", text: $order.streetAdress)
                TextField("Ciudad", text: $order.city)
                TextField("Código Postal", text: $order.zip)
            }
            
            Section {
                NavigationLink ("Hacer pedido") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .onAppear{order.loadUserOrder()} //Reto 3
        .navigationTitle("Detalles de entrega")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AdressView(order: Order())
}

