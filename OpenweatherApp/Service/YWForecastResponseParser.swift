//
//  CityWeatherForesactJSONParser.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 13.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class YWForecastResponseParser {
    
    func parse(json: String) -> [DateWeatherCondition]? {
        let response = YWForecastResponse(JSONString: json)
        if let response = response, let dateForecasts = response.query?.results?.forecasts {
            
            var conditionsList = [DateWeatherCondition] ()
            for dateForecast in dateForecasts {
                let conditions = DateWeatherCondition(
                    dateForecast.date,
                    Int(dateForecast.minTempStr)!,
                    Int(dateForecast.maxTempStr)!)
                conditionsList.append(conditions)
            }
            
            return conditionsList
        } else {
            return nil
        }
    }
}
