//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Marco Eckey on 28.09.23.
//

import Foundation
import SwiftUI
struct UserProfile : View {
    @Environment(\.presentationMode) var presentation
    let firstName = UserDefaults.standard.string(forKey: firstNameKey)!
    let lastName = UserDefaults.standard.string(forKey: lastNameKey)!
    let email = UserDefaults.standard.string(forKey: emailKey)!
    @State var toOnboarding: Bool = false
    var body : some View {
        VStack {
            
            NavigationLink(destination: Onboarding(), isActive: $toOnboarding) {
                EmptyView()
            }
            Text("Personal information")
            Image("profile-picture-placeholder")
                .resizable()
                .frame(width: 200, height: 200)
            Text("First name: \(firstName)")
            Text("Last name: \(lastName)")
            Text("Email: \(email)")
            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                UserDefaults.standard.set("", forKey: firstNameKey)
                UserDefaults.standard.set("", forKey: lastNameKey)
                UserDefaults.standard.set("", forKey: emailKey)
                self.presentation.wrappedValue.dismiss()
                toOnboarding = true
            }) {
                Text("Logout")
            }
            Spacer()
        }
    }
}
