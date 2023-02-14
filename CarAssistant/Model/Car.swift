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
    var rcaExpDate: Date?
    var selectedImage: Data?
    
    init(id: UUID, plateNumber: String, carModel: String, carImage: Data?, rcaExpDate: Date? = nil, selectedImage: Data? = nil) {
        self.id = id
        self.plateNumber = plateNumber
        self.carModel = carModel
        self.carImage = carImage
        self.rcaExpDate = rcaExpDate
        self.selectedImage = selectedImage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        plateNumber = try container.decode(String.self, forKey: .plateNumber)
        carModel = try container.decode(String.self, forKey: .carModel)
        if let carImage = try? container.decode(Data?.self, forKey: .carImage) {
            self.carImage = carImage
        }
        if let rcaExpDate = try? container.decode(Date?.self, forKey: .rcaExpDate) {
            self.rcaExpDate = rcaExpDate
        }
        if let selectedImage = try? container.decode(Data?.self, forKey: .selectedImage) {
            self.selectedImage = selectedImage
        }
    }
//    

    
//    
    enum CodingKeys: CodingKey {
        case id
        case plateNumber
        case carModel
        case carImage
        case rcaExpDate
        case selectedImage
    }
}


