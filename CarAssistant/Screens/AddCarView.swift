//
//  AddCarView.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 26.01.2023.
//

import SwiftUI
import PhotosUI

extension AddCarView {
    
    @MainActor class ViewModel: ObservableObject {
        @Binding var isVisible: Bool
        @Binding var myCars: [Car]
        @Published var myPlateNumber = ""
        @Published var myCarModel = ""
        @Published var selectedItem: PhotosPickerItem? = nil
        @Published var selectedImageData: Data? = nil

        
        init(isVisible: Binding<Bool>, myCars: Binding<[Car]>) {
            _isVisible = isVisible
            _myCars = myCars
        }
        
        func handleSaveAction() {
            myCars.append(Car(id: UUID(), plateNumber: "\(myPlateNumber)", carModel: "\(myCarModel)", carImage: selectedImageData ?? Data()))
            do {
                let encoder = JSONEncoder()
                let myCarsEncoded = try encoder.encode(myCars)
                
                UserDefaults.standard.set(myCarsEncoded, forKey: "myCars")
                UserDefaults.standard.synchronize()
            } catch let error {
                print("error: ", error)
            }
            
            isVisible = false
        }
    }
}

@available(iOS 16.0, *)
struct AddCarView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
                Rectangle()
                    .foregroundColor(.white)
            
            VStack {
                Text("Car Details")
                    .bold()
                    .font(.system(size: 20))
                    .padding()
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
                
                PhotosPicker(selection: $viewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
                    
                    Label {
                        Text("Add a photo")
                    } icon: {
                        
                        if let selectedImage = viewModel.selectedImageData,
                           let uiImage = UIImage(data: selectedImage) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        } else {
                            Image("addPhoto")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                    }
                    Spacer()
                }
                .padding()
                .onChange(of: viewModel.selectedItem) { newItem in
                    Task {
                        // Retrive selected asset in the form of Data
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    viewModel.selectedImageData = data
                        }
                    }
                }
                
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
        AddCarView(viewModel: .init(isVisible: .constant(true), myCars: .constant([.init(id: .init(), plateNumber: "CT96AGP", carModel: "KIA", carImage: Data())])))
    }
}
