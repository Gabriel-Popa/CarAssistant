//
//  CarsManager.swift
//  CarAssistant
//
//  Created by Andrei-Gabriel Popa on 07.02.2023.
//

import Foundation
class CarsManager {
    static let shared = CarsManager()
    
    func getCars() -> [Car] {
        if let encodedCars = UserDefaults.standard.object(forKey: "myCars") as? Data {
            do {
                let decoder = JSONDecoder()
                let cars = try decoder.decode([Car].self, from: encodedCars)
                return cars
            } catch let error {
                print("error: ", error)
            }
        }
        return []
    }
    
    func addCar(car: Car) {
        var cars = getCars()
        cars.append(car)
        save(cars: cars)
    }
    
    func deleteCar(car: Car, onDeleteCompleted: (() -> Void)? = nil) {
        var cars = getCars()
        cars.removeAll(where: {$0.id == car.id})
        save(cars: cars, onDeleteCompleted: onDeleteCompleted)
    }
    
    func updateCar(car: Car) {
        var cars = getCars()
        if let index = cars.firstIndex(where: {$0.id == car.id}) {
            cars[index] = car
            save(cars: cars)
        }
    }
    
    private func save(cars: [Car], onDeleteCompleted: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            do {
                let encoder = JSONEncoder()
                let myCarsEncoded = try encoder.encode(cars)
                
                UserDefaults.standard.set(myCarsEncoded, forKey: "myCars")
                UserDefaults.standard.synchronize()
                
            } catch let error {
                print("error: ", error)
            }
            onDeleteCompleted?()
        }
    }
}
