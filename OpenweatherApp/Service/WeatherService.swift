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
    
    func getAllCities() -> [String] {
        return cityRepository.getAllCities()
    }
    
    func addCity(_ city: String) -> Bool {
        return cityRepository.addCity(city)
    }
    
    func requestWeatherForecast(for city: String, complationHandler: @escaping (CityWeatherForecast) -> ()){
        weatherAPIClient.requestWeatherForecast(for: city) { (forecast) in
            complationHandler(forecast)
        }
    }
}
