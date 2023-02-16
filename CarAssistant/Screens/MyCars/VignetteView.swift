//
//  VignetteView.swift
//  CarAssistant
//
//  Created by Gabriel Popa on 15.02.2023.
//

import SwiftUI
import PhotosUI

extension VignetteView {
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedItem: PhotosPickerItem? = nil
        @Published var selectedImageData: Data? = nil
        @Published var selectedDate = Date()
        @Binding var car: Car
        @Binding var isVisible: Bool
        var completionHandler: (_ car: Car) -> Void
        
        init(car: Binding<Car>, completionHandler: @escaping (_ car: Car) -> Void, isVisible: Binding<Bool>) {
            if let vignetteExpDate = car.wrappedValue.vignetteExpDate {
                self.selectedDate = vignetteExpDate
            }
            
            if let selectedImage = car.wrappedValue.vignetteSelectedImage {
                self.selectedImageData = selectedImage
            }
            _car = car
            self.completionHandler = completionHandler
            _isVisible = isVisible
        }
        
        func saveData() {
            DispatchQueue.main.async { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.car.vignetteExpDate = weakSelf.selectedDate
                weakSelf.car.vignetteSelectedImage = weakSelf.selectedImageData
                weakSelf.completionHandler(weakSelf.car)
                weakSelf.isVisible = false
                weakSelf.setNotificationForVignette(expireDate: weakSelf.selectedDate)
            }
        }
        
        func setNotificationForVignette(expireDate: Date) {
            
            // adding -7 days in seconds
            // basically expireDate - 7days
            let notificationDate = expireDate.addingTimeInterval(-604800)
            let center = UNUserNotificationCenter.current()

            let content = UNMutableNotificationContent()
            content.title = "Vignette"
            content.body = "Your \(car.plateNumber) Vignette will expire on \(notificationDate)"

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: notificationDate.timeIntervalSinceNow, repeats: false)

            let request = UNNotificationRequest(identifier: "ct96agp.vignette", content: content, trigger: trigger)
            print("notificationDate: \(notificationDate.description)")
            center.removePendingNotificationRequests(withIdentifiers: ["ct96agp.vignette"])

            center.add(request) { error in
                if let error = error {
                    print(error)
                }
            }
        }
        
        
        func deletePhoto() {
            self.selectedImageData = nil
        }
    }
}

struct VignetteView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Expiration Date:")
                .bold()
            
            DatePicker(selection: $viewModel.selectedDate, displayedComponents: [.date]) {
                Text("Choose your date")
                    .font(.system(size: 15))
            }
            .navigationTitle("Vignette")
            
            Text("Choose an image/doc:")
                .bold()
            
            PhotosPicker(selection: $viewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
                
                Spacer()
                
                VStack {
                    if let selectedImage = viewModel.selectedImageData,
                       let uiImage = UIImage(data: selectedImage) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(width: 280, height: 280)
                    }
                    VStack {
                        if viewModel.selectedImageData == nil {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 50)
                                
                                Text("Add a photo")
                                    .foregroundColor(.white)
                            }
                        } else {
                            VStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 150, height: 50)
                                    Text("Edit photo")
                                        .foregroundColor(.white)
                                    
                                }
                                Button {
                                    viewModel.deletePhoto()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 150, height: 50)
                                        Text("Delete photo")
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
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
            .toolbar {
                Button {
                    
                    viewModel.saveData()
                    
                } label: {
                    Text("Save")
                }
            }
            Spacer()
        }
        .padding(.horizontal, 30)
        .padding(.top, 30)
    }
}
struct VignetteView_Previews: PreviewProvider {
    static var previews: some View {
        VignetteView(viewModel: .init(car: .constant(.init(id: .init(), plateNumber: "CT-05-321", carModel: "Kia Sorento", carImage: nil)), completionHandler: { car in }, isVisible: .constant(true)))
        
    }
}
