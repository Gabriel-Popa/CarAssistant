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
        @Published var isItpViewVisible = false
        @Published var isVignetteViewVisible = false
        
        init(car: Car) {
            self.car = car
        }
        
        func handleCarUpdate(car: Car) {
            CarsManager.shared.updateCar(car: car)
        }
        
        func handleRcaAddButton() {
            self.isRcaViewVisible = true
        }
        
        func handleItpAddButton() {
            self.isItpViewVisible = true
        }
        
        func handleVignetteAddButton() {
            self.isVignetteViewVisible = true
        }
        
        func calculateRcaInterval() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            return dateFormatter.string(from: car.rcaExpDate!)
        }
        
        func calculateItpInterval() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            return dateFormatter.string(from: car.itpExpDate!)
        }
        
        func calculateVignetteInterval() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            return dateFormatter.string(from: car.vignetteExpDate!)
            
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
                                viewModel.handleItpAddButton()
                            } label: {
                                if viewModel.car.itpExpDate == nil {
                                    Text("Add expiration date")
                                } else {
                                    Text("Edit expiration date")
                                }
                            }
                        }
                        
                        if viewModel.car.itpExpDate != nil {
                            Text("Your ITP will expire on \(viewModel.calculateItpInterval()) !")
                                .font(.system(size: 15))
                                .padding()
                        } else {
                            Text("")
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text("Auto Liability Insurance(RCA):")
                                .bold()
                                .font(.system(size: 16))
                            
                            Button {
                                viewModel.handleRcaAddButton()
                            } label: {
                                
                                if viewModel.car.rcaExpDate == nil {
                                    Text("Add expiration date")
                                } else {
                                    Text("Edit expiration date")
                                }
                            }
                        }
                    }
                    if viewModel.car.rcaExpDate != nil {
                        Text("Your RCA will expire on \(viewModel.calculateRcaInterval()) !")
                            .font(.system(size: 15))
                            .padding()
                    } else {
                        Text("")
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack() {
                            Text("Vignette:")
                                .bold()
                                .font(.system(size: 16))
                            
                            Button {
                                viewModel.handleVignetteAddButton()
                            } label: {
                                
                                if viewModel.car.vignetteExpDate == nil {
                                    Text("Add expiration date")
                                } else {
                                    Text("Edit expiration date")
                                }
                            }
                        }
                    }
                    if viewModel.car.vignetteExpDate != nil {
                        Text("Your Vignette will expire on \(viewModel.calculateVignetteInterval()) !")
                            .font(.system(size: 15))
                            .padding()
                    } else {
                        Text("")
                    }
                    
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
                
                NavigationLink(isActive: $viewModel.isItpViewVisible) {
                    ItpView(viewModel: .init(car: $viewModel.car, completionHandler: { car in
                        viewModel.handleCarUpdate(car: viewModel.car)
                    }, isVisible: $viewModel.isItpViewVisible))
                } label: {
                    EmptyView()
                }
                
                NavigationLink(isActive: $viewModel.isVignetteViewVisible) {
                    VignetteView(viewModel: .init(car: $viewModel.car, completionHandler: { car in
                        viewModel.handleCarUpdate(car: viewModel.car)
                    }, isVisible: $viewModel.isVignetteViewVisible))
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
