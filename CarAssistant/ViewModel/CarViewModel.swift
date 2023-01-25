//
//  CarViewModel.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 25.01.2023.
//

import Foundation

class CarViewModel: ObservableObject {
    
    @Published var cars = [Car]()
    
}
