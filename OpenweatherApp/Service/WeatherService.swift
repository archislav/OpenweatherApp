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
    var weatherAPIClient = YahooWeatherAPIClient.shared
    
    private init() {}
    
    func getAllCities() -> [City] {
        return cityRepository.getAllCities()
    }
    
    func addCity(_ city: City) -> Bool {
        return cityRepository.addCity(city)
    }
    
    func requestWeatherForecast(for city: City, completionHandler: @escaping (CityWeatherForecast) -> ()) {
        weatherAPIClient.requestWeatherForecast(for: city) { (conditions) in
            let forecast = CityWeatherForecast(city: city, conditions: conditions)
            completionHandler(forecast)
        }
    }
}
