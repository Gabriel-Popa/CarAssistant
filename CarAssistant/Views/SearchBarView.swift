//
//  SearchBarView.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 25.01.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var myCarText: String
    @Binding var myPlateNumberText: String
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Plate Number", text: $myPlateNumberText)
                .foregroundColor(.gray)
                .padding(.leading, 13)
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
            
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Car Model", text: $myCarText)
                .foregroundColor(.gray)
                .padding(.leading, 13)
            }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
        }
    }
}
