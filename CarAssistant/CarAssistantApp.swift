//
//  CarAssistantApp.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 23.01.2023.
//

import SwiftUI

@main
struct CarAssistantApp: App {
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if let error = error {
                print(error)
            }
        }
    }
    var body: some Scene {
        WindowGroup {
                SplashScreenView()
//            CarAssistantTabView()
        }
    }
}
