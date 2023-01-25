//
//  MyCarsView.swift
//  Car Assistant
//
//  Created by Andrei-Gabriel Popa on 22.01.2023.
//

import SwiftUI

extension MyCarsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var cars = [Car]()
    }
}

struct MyCarsView: View {
    
    @StateObject var viewModel: ViewModel = .init()
    @State var isShowing = false
    @State var myPlateNumber = ""
    @State var myCarModel = ""
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(viewModel.cars) { myCar in
                        HStack {
                            ImageCardView()
                            
                            VStack {
                                Text("Plate Number")
                                    .bold()
                                Text("Car model")
                            }
                        }
                        .padding(.trailing, 90)
                    }
                }
            }
            
            VStack {
                Spacer()
                Button {
                    self.isShowing = true
                } label: {
                    
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 41, height: 41)
                        Text("Add a new car")
                            .font(.system(size: 17))
                            .foregroundColor(.black)
                    }
                }
                .sheet(isPresented: $isShowing) {
                    ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                        
                        VStack {
                            HStack {
                                TextField("Plate Number", text: $myPlateNumber)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 13)
                            }
                            .frame(height: 40)
                            .cornerRadius(13)
                            .padding()
                            
                            HStack {
                                TextField("Car Model", text: $myCarModel)
                                    .foregroundColor(.gray)
                                    .padding(.leading, 13)
                            }
                            .frame(height: 40)
                            .cornerRadius(13)
                            .padding()
                            
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct MyCarsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCarsView()
    }
}
