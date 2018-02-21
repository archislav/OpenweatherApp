//
//  CityWeatherViewProtocol.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 20.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

protocol CityWeatherViewProtocol: class {
    
    func setCity(_ city: City)
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast) 
}
