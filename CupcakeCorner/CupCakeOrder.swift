//
//  CupCakeOrder.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/21/24.
//

import SwiftUI

struct CupCakeOrder: View {
    @State private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity,in:1...20)
                }
                Section{
                    Toggle("Special Requsts", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Add frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink("Delivery Details"){
                        AddressView(order: order)
                    }
                }
                
            }
            .navigationTitle("Cupcakery")
        }
    }
    
    
}

#Preview {
    CupCakeOrder()
}
