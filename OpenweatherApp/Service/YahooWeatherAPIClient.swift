//
//  YahooWeatherAPIClient.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 09.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import os.log

class YahooWeatherAPIClient {

    static let YAHOO_WEATHER_API_URL = "https://query.yahooapis.com/v1/public/yql"
    
    static let shared = YahooWeatherAPIClient()
    
    private init() {}
    
    func requestWeatherForecast(for city: String, successCallback: @escaping (CityWeatherForecast) -> ())   {
        let parameters = createWeatherForecastParameters(for: city)
        
        doRequestWeatherForecast(parameters, successCallback)
    }
    
    private func doRequestWeatherForecast(_ parameters: [String: String], _ completionHandler: @escaping (CityWeatherForecast) -> ()) {
        HTTPUtils.executePOSTRequest(url: YahooWeatherAPIClient.YAHOO_WEATHER_API_URL, with: parameters, completionHandler: { data, response, error in
            if let weatherForecast = self.handleWeatherForecastResponse(data, response, error) {
                completionHandler(weatherForecast)
            }
         })
    }
    
    private func createWeatherForecastParameters(for city: String) -> [String: String] {
        let parameters: [String: String] = [
            "q": "select item.forecast from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"\(city), ru\") and u='c'",
            "format": "json"
        ]
        
        return parameters
    }
    
    private func handleWeatherForecastResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> CityWeatherForecast? {
        guard error == nil else {
            os_log("Got error on request: %@", type: .error, error.debugDescription)
            return nil
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            guard statusCode == HTTPUtils.STATUS_CODE_OK else {
                os_log("Got response status code: %d", type: .error, statusCode)
                return nil
            }
        }
        
        guard let data = data else {
            os_log("Got empty data on request", type: .error)
            return nil
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
            os_log("Response body: %@", json)
            
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
        } catch let error {
            os_log("Error on response parsing: %@", type: .error, error.localizedDescription)
            return nil
        }
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
