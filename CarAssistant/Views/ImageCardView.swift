//
//  ImageCardView.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 23.01.2023.
//

import SwiftUI

struct ImageCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Image("Noimage")
                .resizable()
                .scaledToFit()
                .frame(width: 93, height: 73)
        }
    }
}

struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardView()
    }
}
