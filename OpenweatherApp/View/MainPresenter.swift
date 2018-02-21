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
        self.cities = weatherService.getAllCities()
        mainView.setCities(cities: self.cities)
    }
    
    func askUserToAddCity() {
        mainView.showAddCityDialog()
    }
    
    func enteredCityToAdd() {
        if let cityToAdd = mainView.getCityToAdd() {
            let cityWasAdded = weatherService.addCity(cityToAdd)
            if cityWasAdded {
                cities.append(cityToAdd)
                mainView.addCity(cityToAdd)
            }
        }
    }
}
