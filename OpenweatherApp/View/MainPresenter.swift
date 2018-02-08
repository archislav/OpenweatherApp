//
//  MainPresenter.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
    
    weak var mainView: MainViewProtocol!
    
    let weatherService = WeatherService.shared
    
    var cities: [String]!
    
    // MARK: MainPresenterProtocol methods
    
    required init(mainView: MainViewProtocol) {
        self.mainView = mainView
    }
    
    func initialize() {
        // todo:
//        let forecasts = [CityWeatherForecast(city: "Moscow"), CityWeatherForecast(city: "London"), CityWeatherForecast(city: "Alushta")]
        self.cities = weatherService.getAllCities()
        mainView.setCities(cities: self.cities)
    }
    
    func currentCityChanged() {
        let cityIndex = mainView.getCurrentCityIndex()
        let city = cities[cityIndex]
        
        weatherService.requestWeatherForecast(for: city) { (weatherForecast) in
            mainView.setWeatherForecast(weatherForecast, for: cityIndex)
        }
    }
}
