//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/21/24.
//

import SwiftUI

struct CheckoutView: View {
    var order : Order
    
    @State private var confirmationMessage = ""
    @State private var showConfimationMessage = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale : 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height:256)
                
                Text("Total Cost \(order.cost, format: .currency(code:"USD"))")
                    .font(.title)
                Button("Place Order" ){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Checkout Window")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("TY", isPresented: $showConfimationMessage){
            Button("OK"){}
        }message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async{
        guard let encoded = try? JSONEncoder().encode(order) else{
            print("Failed to encode orde")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url:url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let(data, _) = try await URLSession.shared.upload(for: request,from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) cupcakes are its way"
            
            showConfimationMessage = true
        }catch{
            print("Checkout failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckoutView(order : Order())
}
