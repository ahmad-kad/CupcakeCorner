//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/21/24.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        List{
            Section ("Information") {
                VStack {
                    TextField("Name", text: $order.name)
                    TextField("Street Name", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
            }
            
            Section {
                NavigationLink("Checkout") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Address")
        .navigationBarTitleDisplayMode(.inline)

        
    }
}

#Preview {
    AddressView(order: Order())
}
