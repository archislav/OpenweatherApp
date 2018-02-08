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
    
    required init(mainView: MainViewProtocol) {
        self.mainView = mainView
    }
    
    func initialize() {
        // todo:
        let forecasts = [CityWeatherForecast(city: "Moscow"), CityWeatherForecast(city: "London"), CityWeatherForecast(city: "Alushta")]
        mainView.setCityWeatherForecasts(forecasts: forecasts)
    }
}
