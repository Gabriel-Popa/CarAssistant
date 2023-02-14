//
//  AddAlertsView.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 23.01.2023.
//

import SwiftUI

extension AddAlertsView {
    @MainActor class ViewModel: ObservableObject {
        @Published var car: Car
        @Published var isRcaViewVisible = false
        
        
        init(car: Car) {
            self.car = car
        }
        
        func handleCarUpdate(car: Car) {
            CarsManager.shared.updateCar(car: car)
        }
        
        func handleAddButton() {
            self.isRcaViewVisible = true

        }
    }
}

struct AddAlertsView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer().frame(width: 60)
                        
                        Image(uiImage: (UIImage(data: viewModel.car.carImage!) ?? UIImage(named: "Noimage"))!)
                            .resizable()
                            .cornerRadius(10)
                            .frame(width: 135, height: 90)
                        
                        VStack {
                            Text("\(viewModel.car.plateNumber)")
                                .bold()
                                .font(.system(size: 16))
                            Text("\(viewModel.car.carModel)")
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Technical Inspection(ITP):")
                                .bold()
                                .font(.system(size: 16))
                            Button {
                                
                            } label: {
                                Text("Add expiration date")
                            }


                        }
                        
                        Text("Your ITP will expire in n days !")
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
                                viewModel.handleAddButton()
                            } label: {
                                
                                if viewModel.car.rcaExpDate == nil {
                                    Text("Add expiration date")
                                } else {
                                    Text("Edit expiration date")
                                }
                            }
                        }
                    }
                    
                    Text("Your RCA will expire in n days !")
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
            
            
            NavigationLink(isActive: $viewModel.isRcaViewVisible) {
                RcaView(viewModel: .init(car: $viewModel.car, completionHandler: { car in
                    viewModel.handleCarUpdate(car: viewModel.car)
                }, isVisible: $viewModel.isRcaViewVisible))
            } label: {
                EmptyView()
            }
                
            }
        }
        
    }
}

struct AddAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        AddAlertsView(viewModel: .init(car: Car(id: UUID(), plateNumber: "", carModel: "", carImage: Data())))
    }
}
