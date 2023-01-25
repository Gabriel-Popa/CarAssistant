//
//  MyCarsView.swift
//  Car Assistant
//
//  Created by Andrei-Gabriel Popa on 22.01.2023.
//

import SwiftUI

struct MyCarsView: View {
    
    @StateObject var car: CarViewModel
    @State var isShowing = false
    @State var myPlateNumber = ""
    @State var myCarModel = ""
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(car.cars) { myCar in
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
                    TextField("Plate Number", text: $myPlateNumber)
                    TextField("Car model", text: $myCarModel)
                }
                Spacer()
            }
        }
    }
}

struct MyCarsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCarsView(car: CarViewModel())
    }
}
