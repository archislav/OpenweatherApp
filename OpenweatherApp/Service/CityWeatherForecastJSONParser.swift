//
//  CityWeatherForesactJSONParser.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 13.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class CityWeatherForecastJSONParser {
    
    func parse(json: [String: Any]) -> CityWeatherForecast? {
        let container = JSONUtils.getJSONArrayFromJson(json, ["query", "results"], "channel")
        
        let forecastPath = ["item", "forecast"]
        
        let dateFormatter = createDateFormatter()
        
        var conditionsList = [DateWeatherCondition]()
        
        for forecastBlock in container {
            let dateStr = JSONUtils.getStringFromJson(forecastBlock, forecastPath, "date")
            let minTemp = JSONUtils.getIntFromJson(forecastBlock, forecastPath, "low")
            let maxTemp = JSONUtils.getIntFromJson(forecastBlock, forecastPath, "high")
            
            let conditions = DateWeatherCondition(dateFormatter.date(from: dateStr)!, minTemp, maxTemp)
            conditionsList.append(conditions)
        }
        
        var forecast = CityWeatherForecast()
        forecast.dateWeatherConditions = conditionsList
        
        return forecast
    }
    
    private func createDateFormatter() -> DateFormatter {
        // вид даты 09 Feb 2018
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        return dateFormatter
    }
}
