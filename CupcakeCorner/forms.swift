//
//  forms.swift
//  CupcakeCorner
//
//  Created by ahmad kaddoura on 1/20/24.
// validate and disable forms

import SwiftUI

struct forms: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm : Bool{
        username.count < 4 || email.count < 5
    }
    var body: some View {
        Form {
            Section{
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            Section{
                Button("Create Account"){
                    print("Creating Account...")
                }
                
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    forms()
}
