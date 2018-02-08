//
//  WeatherService.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class WeatherService {
    
    static var shared = WeatherService()
    
    var cityRepository = CityRepository.shared
    
    private init() {}
    
    func getAllCities() -> [String] {
        return cityRepository.getAllCities()
    }
    
    func requestWeatherForecast(for city: String, complationHandler: (CityWeatherForecast) -> ()){
        // todo: add API Client Here
        complationHandler(CityWeatherForecast(city: city))
    }
}
