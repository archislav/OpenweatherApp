//
//  CityRepository.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import os.log

class CityRepository {
    
    static let UD_CITIES_KEY = "cities"
    
    static var shared = CityRepository()
    
    private init(){
        if let cities = UserDefaults.standard.value(forKey: CityRepository.UD_CITIES_KEY) as? [String] {
            os_log("Cities already initialized")
        } else {
            let cities = ["Moscow", "Kazan", "Samara"]
            UserDefaults.standard.set(cities, forKey: CityRepository.UD_CITIES_KEY)
            os_log("Cities initialized with: %@", cities)
        }
    }
    
    func getAllCities() -> [String] {
        return UserDefaults.standard.value(forKey: CityRepository.UD_CITIES_KEY) as! [String]
    }
    
    func addCity(_ city: String) -> Bool {
        var cities = getAllCities()
        if !cities.contains(city) {
            cities.append(city)
            UserDefaults.standard.set(cities, forKey: CityRepository.UD_CITIES_KEY)
            os_log("Added city: %@", city)
            return true
        } else {
            return false
        }
    }
    
}
