//
//  CityWeatherPresenterProtocol.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 20.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

protocol CityWeatherPresenterProtocol {
    
    init(view: CityWeatherViewProtocol)
    
    func setCity(_ city: String)
    
    func initialize()
    
    func askUserToAddCity()
}
