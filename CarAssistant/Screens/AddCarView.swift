//
//  AddCarView.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 26.01.2023.
//

import SwiftUI

extension AddCarView {
    
    @MainActor class ViewModel: ObservableObject {
        @Binding var isVisible: Bool
        @Binding var myCars: [Car]
        @Published var myPlateNumber = ""
        @Published var myCarModel = ""
        
        init(isVisible: Binding<Bool>, myCars: Binding<[Car]>) {
            _isVisible = isVisible
            _myCars = myCars
        }
        
        func handleSaveAction() {
            myCars.append(Car(id: UUID(), plateNumber: "\(myPlateNumber)", carModel: "\(myCarModel)", carImage: ""))
            isVisible = false
        }
    }
}

struct AddCarView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
                Rectangle()
                    .foregroundColor(.white)
            
            VStack {
                HStack {
                    TextField("Plate Number", text: $viewModel.myPlateNumber)
                        .foregroundColor(.black)
                        .padding(.leading, 13)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                
                HStack {
                    TextField("Car Model", text: $viewModel.myCarModel)
                        .foregroundColor(.black)
                        .padding(.leading, 13)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                
                Button {
                    viewModel.handleSaveAction()
                } label: {
                    Text("Save")
                }

                Spacer()
            }
        }
    }
}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarView(viewModel: .init(isVisible: .constant(true), myCars: .constant([.init(id: .init(), plateNumber: "CT96AGP", carModel: "KIA", carImage: "CEE'D")])))
    }
}
