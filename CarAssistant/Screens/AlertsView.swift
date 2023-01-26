//
//  AlertsView.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 23.01.2023.
//

import SwiftUI

struct AlertsView: View {
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Spacer().frame(width: 60)
                    
                    ImageCardView()
            
                    VStack {
                        Text("Plate number")
                            .bold()
                            .font(.system(size: 16))
                        Text("Car model")
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Technical Inspection(ITP):")
                            .bold()
                            .font(.system(size: 16))
                        Button {
                            //TODO: Implement add button
                            
                        } label: {
                            Text("Add expiration date")
                            
                        }
                    }
                    
                    Text("Your technical inspection will expire in n days !")
                        .font(.system(size: 15))
                        .padding()
                }
                
                Spacer()

                VStack {
                    HStack {
                        Text("Auto Liability Insurance(RCA):")
                            .bold()
                            .font(.system(size: 16))

                        Button {
                            //TODO: Implement add button
                        } label: {
                            Text("Add expiration date")
                        }
                    }
                }
                
                Text("Your auto liability insurance will expire in n days !")
                    .font(.system(size: 15))
                    .padding()
                
                Spacer()
                
                VStack {
                    HStack() {
                        Text("Vignette:")
                            .bold()
                            .font(.system(size: 16))

                        Button {
                            //TODO: Implement add button
                        } label: {
                            Text("Add expiration date")
                        }
                    }
                }
                
                Text("Your vignette will expire in n days !")
                    .font(.system(size: 15))
                    .padding()
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("Alerts")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsView()
    }
}
