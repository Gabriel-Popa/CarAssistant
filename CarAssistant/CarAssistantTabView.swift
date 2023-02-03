//
//  CarAssistantTabView.swift
//  Car Assistant
//
//  Created by Andrei-Gabriel Popa on 22.01.2023.
//

import SwiftUI

struct CarAssistantTabView: View {
    
    static var myCarsTab = 0
    static var alertsTab = 1
    
    @State var selectedTab = myCarsTab
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            MyCarsView()
                .tabItem {
                    VStack {
                        Image(systemName: "car")
                        Text("My cars")
                }
            }
            .tag(CarAssistantTabView.myCarsTab)
            
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
