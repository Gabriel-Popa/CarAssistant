//
//  MyCarsView.swift
//  Car Assistant
//
//  Created by Andrei-Gabriel Popa on 22.01.2023.
//

import SwiftUI

extension MyCarsView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var toAddCar = false
        @Published var cars: [Car] = []
        
        func onAppear() {
            self.cars = CarsManager.shared.getCars()
        }
        
        func handleAddAction() {
            self.toAddCar = true
        }
        
        func isButtonFromListVisible() -> Bool {
            return cars.isEmpty
        }
        
        func isButtonFromNavigationBarVisible() -> Bool {
            return cars.isEmpty == false
        }
        
        func deleteCar(at offSets: IndexSet) {
            if let index = offSets.first {
                CarsManager.shared.deleteCar(car: cars[index]) {
                    self.cars = CarsManager.shared.getCars()
                }
            }
        }
    }
}

struct MyCarsView: View {
    
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack {
                        List {
                            ForEach(viewModel.cars) { myCar in
                                
                                NavigationLink {
                                    AddAlertsView(viewModel: .init(car: myCar))
                                    
                                } label: {
                                    
                                    HStack() {
                                        Image(uiImage: (UIImage(data: myCar.carImage!) ?? UIImage(named: "Noimage"))!)
                                            .resizable()
                                            .cornerRadius(10)
                                            .frame(width: 135, height: 90)
                                            .shadow(radius: 3)
                                        
                                        VStack(alignment: .leading) {
                                            Text("\(myCar.plateNumber)")
                                                .bold()
                                            Text("\(myCar.carModel)")
                                        }
                                        Spacer()
                                        
                                    }
                                }
                                .foregroundColor(.black)
                            }
                            .onDelete(perform: viewModel.deleteCar)
                        }
                }
                
                if viewModel.isButtonFromListVisible() {
                    
                    VStack {
                        Spacer()
                        Button {
                            viewModel.handleAddAction()
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
                        Spacer()
                    }
                }
            }.onAppear(perform: {
                viewModel.onAppear()
            })
            .sheet(isPresented: $viewModel.toAddCar) {
                AddCarView(viewModel: .init(isVisible: $viewModel.toAddCar, myCars: $viewModel.cars))
            }
            .navigationTitle("My Cars")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                Button {
                    
                    viewModel.handleAddAction()
                    
                } label: {
                    
                    if viewModel.isButtonFromNavigationBarVisible() {
                        
                        Spacer()
                        
                        VStack {
                            Text("Add Car")
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct MyCarsView_Previews: PreviewProvider {
    static var previews: some View {
        MyCarsView()
    }
}
