//
//  MainViewProtocol.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
    func setCities(cities: [String])
    
    func getCurrentCityIndex() -> Int
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast, for cityIndex: Int)
}
