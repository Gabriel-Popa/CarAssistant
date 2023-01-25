//
//  Car.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 25.01.2023.
//

import Foundation

struct Car: Identifiable {
    
    var id:UUID
    var plateNumber: String
    var carModel: String
    var carImage: String
    
    init(id: UUID, plateNumber: String, carModel: String, carImage: String) {
        self.id = id
        self.plateNumber = plateNumber
        self.carModel = carModel
        self.carImage = carImage
        
    }
}
