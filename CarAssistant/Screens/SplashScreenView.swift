//
//  SplashScreenView.swift
//  Car Assistant
//
//  Created by Andrei-Gabriel Popa on 22.01.2023.
//

import SwiftUI

extension SplashScreenView {
    @MainActor class ViewModel: ObservableObject {
        @Published var toMainScreen: Bool = false
    }
}

struct SplashScreenView: View {
    
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
            NavigationView {
                ZStack {
                    Color(.systemBlue)
                        .ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack {
                        Image(systemName: "car")
                            .resizable()
                            .frame(width: 127, height: 122)
                            .foregroundColor(.white)
                            .shadow(radius: 25, x: 10, y: 5)
                        Text("Car's Assistant")
                            .bold()
                            .font(.largeTitle)
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .shadow(radius: 25, x: 7, y: 5)
                        
                    }
                    Spacer()
                    
                    NavigationLink(isActive: $viewModel.toMainScreen) {
                        CarAssistantTabView()
                    } label: {
                        EmptyView()
                    }
                }
                    
                }.onAppear {
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.5) {
                        withAnimation {
                            viewModel.toMainScreen = true
                        }
                    }
                }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
