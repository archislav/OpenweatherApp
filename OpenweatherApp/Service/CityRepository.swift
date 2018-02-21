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
        if let cityNames = UserDefaults.standard.value(forKey: CityRepository.UD_CITIES_KEY) as? [String] {
            os_log("Cities already initialized")
        } else {
            let cities = ["Moscow", "Kazan", "Samara"]
            UserDefaults.standard.set(cities, forKey: CityRepository.UD_CITIES_KEY)
            os_log("Cities initialized with: %@", cities)
        }
    }
    
    func getAllCities() -> [City] {
        let cityNames = UserDefaults.standard.value(forKey: CityRepository.UD_CITIES_KEY) as! [String]
        return cityNames.map() {(cityName) in City(name: cityName)}
    }
    
    func addCity(_ city: City) -> Bool {
        var cities = getAllCities()
        if !cities.contains(city) {
            cities.append(city)
            let cityNames = cities.map() {(city) in city.name}
            UserDefaults.standard.set(cityNames, forKey: CityRepository.UD_CITIES_KEY)
            os_log("Added city: %@", city.name)
            return true
        } else {
            return false
        }
    }
    
}
