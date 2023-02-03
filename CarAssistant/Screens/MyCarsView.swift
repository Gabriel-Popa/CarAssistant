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
        @Published var cars = [Car]()
        
        init() {
            let encodedCars = UserDefaults.standard.object(forKey: "myCars") as! Data
            do {
                let decoder = JSONDecoder()
                let cars = try decoder.decode([Car].self, from: encodedCars)
                self.cars = cars
            } catch let error {
                print("error: ", error)
            }
            
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
    }
}

struct MyCarsView: View {
    
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                VStack {
                    ScrollView {
                        ForEach(viewModel.cars) { myCar in
                            
                            NavigationLink {
                                AlertsView()
                            } label: {
//                                ZStack(alignment: .leading) {
//                                    RoundedRectangle(cornerRadius: 20)
//                                        .padding()
//                                        .shadow(radius: 3)
                                    HStack() {
                                        Image(uiImage: (UIImage(data: myCar.carImage!) ?? UIImage(named: "Noimage"))!)
                                            .resizable()
                                            .cornerRadius(10)
                                            .frame(width: 90, height: 90)
                                        
                                        VStack(alignment: .leading) {
                                            Text("\(myCar.plateNumber)")
                                                .bold()
                                            Text("\(myCar.carModel)")
                                        }
                                        Spacer()
                                        
                                    }
                                    .padding(.leading, 20)
                                
//                                }
//                                .frame(width: 380, height: 120)
//                                .foregroundColor(.white)
//                                Spacer()
                            }
                            .foregroundColor(.black)
                        }
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
            }
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
