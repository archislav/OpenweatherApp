//
//  CityWeatherForecast.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

struct CityWeatherForecast {
    
    var city: City
    var dateWeatherConditions = [DateWeatherCondition]()
    
    init(city: City, conditions: [DateWeatherCondition]) {
        self.city = city
        self.dateWeatherConditions = conditions
    }
}
