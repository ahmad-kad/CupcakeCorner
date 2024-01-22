//
//  Haptics.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/20/24.
//  Adds vibration to iPhone when counter is changed - Simple

import SwiftUI

struct Haptics: View {
    @State private var counter = 0
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Tap count: \(counter)"){
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
    }
}

#Preview {
    Haptics()
}
