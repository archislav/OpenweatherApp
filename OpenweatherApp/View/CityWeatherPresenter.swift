//
//  CityWeatherPresenter.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 20.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class CityWeatherPresenter: CityWeatherPresenterProtocol {
    
    var view: CityWeatherViewProtocol
    
    // todo: придумать как вынести MainPresenter
    var mainPresenter: MainPresenterProtocol!
    
    var weatherService = WeatherService.shared
    
    var city: City?
    
    required init(view: CityWeatherViewProtocol) {
        self.view = view
    }
    
    // todo: придумать как вынести MainPresenter
    convenience init(view: CityWeatherViewProtocol, mainPresenter: MainPresenterProtocol) {
        self.init(view: view)
        self.mainPresenter = mainPresenter
    }
    
    func setCity(_ city: City) {
        self.city = city
    }
    
    func initialize() {
        if let currentCity = city {
            self.view.setCity(currentCity)
            weatherService.requestWeatherForecast(for: currentCity) { (forecast) in
                self.view.setWeatherForecast(forecast)
            }
        }
    }
    
    func askUserToAddCity() {
        self.mainPresenter.askUserToAddCity()
    }
}
