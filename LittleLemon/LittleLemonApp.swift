//
//  LittleLemonApp.swift
//  LittleLemon
//
//  Created by Marco Eckey on 28.09.23.
//

import SwiftUI

@main
struct LittleLemonApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    Home()
                } else {
                    Onboarding()
                }
            }
        }
    }
}
