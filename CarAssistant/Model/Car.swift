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
    var itpExpDate: Date?
    var rcaExpDate: Date?
    var vignetteExpDate: Date?
    var rcaSelectedImage: Data?
    var itpSelectedImage: Data?
    var vignetteSelectedImage: Data?
    
    
    init(id: UUID, plateNumber: String, carModel: String, carImage: Data?, itpExpDate: Date? = nil , itpSelectedImage: Data? = nil, rcaExpDate: Date? = nil, rcaSelectedImage: Data? = nil, vignetteExpDate: Date? = nil, vignetteSelectedImage: Data? = nil) {
        self.id = id
        self.plateNumber = plateNumber
        self.carModel = carModel
        self.carImage = carImage
        self.itpSelectedImage = itpSelectedImage
        self.rcaSelectedImage = rcaSelectedImage
        self.itpExpDate = itpExpDate
        self.rcaExpDate = rcaExpDate
        self.vignetteExpDate = vignetteExpDate
        
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
        if let rcaSelectedImage = try? container.decode(Data?.self, forKey: .rcaSelectedImage) {
            self.rcaSelectedImage = rcaSelectedImage
        }
        if let itpExpDate = try? container.decode(Date?.self, forKey: .itpExpDate) {
            self.itpExpDate = itpExpDate
        }
        if let itpSelectedImage = try? container.decode(Data?.self, forKey: .itpSelectedImage) {
            self.itpSelectedImage = itpSelectedImage
        }
        if let vignetteExpDate = try? container.decode(Date?.self, forKey: .vignetteExpDate) {
            self.vignetteExpDate = vignetteExpDate
        }
        if let vignetteSelectedImage = try? container.decode(Data?.self, forKey: .vignetteSelectedImage) {
            self.vignetteSelectedImage = vignetteSelectedImage
        }
        
    }
//    

    
//    
    enum CodingKeys: CodingKey {
        case id
        case plateNumber
        case carModel
        case carImage
        case itpExpDate
        case rcaExpDate
        case vignetteExpDate
        case itpSelectedImage
        case rcaSelectedImage
        case vignetteSelectedImage
    }
}


