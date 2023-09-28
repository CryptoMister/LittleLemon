//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Marco Eckey on 28.09.23.
//

import Foundation
import SwiftUI 
let kIsLoggedIn = "kIsLoggedIn"
let firstNameKey = "firstName"
let lastNameKey = "lastName"
let emailKey = "email"
struct Onboarding : View {
    @State var firstName : String = ""
    @State var lastName : String  = ""
    @State var email : String  = ""
    @State var buttonPressed : Bool = false
    @State var isLoggedIn : Bool = false
    var body : some View {
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                Button(action : {
                    UserDefaults.standard.set(firstName, forKey: firstNameKey)
                    UserDefaults.standard.set(lastName, forKey: lastNameKey)
                    UserDefaults.standard.set(email, forKey: emailKey)
                    UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                    isLoggedIn = true 
                }) {
                    Text("Register")
                }
            }
            .padding()
        }
    }
}
