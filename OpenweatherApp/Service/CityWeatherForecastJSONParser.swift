//
//  CityWeatherForesactJSONParser.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 13.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class CityWeatherForecastJSONParser {
    
    func parse(json: String) -> CityWeatherForecast? {
        let response = YWForecastResponse(JSONString: json)
        if let response = response, let dateForecasts = response.query.results.forecasts {
            var forecast = CityWeatherForecast()
            
            for dateForecast in dateForecasts {
                let conditions = DateWeatherCondition(
                    dateForecast.date,
                    Int(dateForecast.minTempStr)!,
                    Int(dateForecast.maxTempStr)!)
                forecast.dateWeatherConditions.append(conditions)
            }
            
            return forecast
        } else {
            return nil
        }
    }
}
