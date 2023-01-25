//
//  CarAssistantTabView.swift
//  Car Assistant
//
//  Created by Andrei-Gabriel Popa on 22.01.2023.
//

import SwiftUI

struct CarAssistantTabView: View {
    
    static var myCarTab = 0
    static var alertsTab = 1
    
    @State var selectedTab = myCarTab
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            MyCarsView()
                .navigationTitle("My Cars")
                .navigationBarTitleDisplayMode(.inline)
                .tabItem {
                    VStack {
                        Image(systemName: "car")
                        Text("My cars")
                }
            }
                .tag(CarAssistantTabView.myCarTab)
            
            AlertsView()
                .tabItem {
                    VStack {
                        Image(systemName: "bell")
                        Text("Alerts")
                    }
                }
                .tag(CarAssistantTabView.alertsTab)
        }
    }
}

struct CarAssistantTabView_Previews: PreviewProvider {
    static var previews: some View {
        CarAssistantTabView()
    }
}
