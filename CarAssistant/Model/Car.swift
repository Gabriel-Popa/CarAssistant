//
//  Car.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 25.01.2023.
//

import Foundation

class Car: Identifiable, Codable {
    
    var id:UUID
    var plateNumber: String
    var carModel: String
    var carImage: Data?
    
    init(id: UUID, plateNumber: String, carModel: String, carImage: Data?) {
        self.id = id
        self.plateNumber = plateNumber
        self.carModel = carModel
        self.carImage = carImage
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        plateNumber = try container.decode(String.self, forKey: .plateNumber)
        carModel = try container.decode(String.self, forKey: .carModel)
        carImage = try container.decode(Data?.self, forKey: .carImage)
    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(plateNumber, forKey: .plateNumber)
//        try container.encode(carModel, forKey: .carModel)
//        try container.encode(carImage, forKey: .carImage)
//    }
//    
    enum CodingKeys:String, CodingKey {
        case id
        case plateNumber
        case carModel
        case carImage
    }
}


