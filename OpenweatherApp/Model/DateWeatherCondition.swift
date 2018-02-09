//
//  DayWeatherCondition.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 09.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

struct DateWeatherCondition {
    
    var date: Date
    var minTemp: Int
    var maxTemp: Int
    
    init(_ date: Date, _ minTemp: Int, _ maxTemp: Int) {
        self.date = date
        self.minTemp = minTemp
        self.maxTemp = maxTemp
    }
}
