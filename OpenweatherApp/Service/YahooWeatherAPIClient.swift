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
            "q": "select item.forecast from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"\(city), ru\" limit 1) and u='c'",
            "format": "json"
        ]
        
        print(">>> q: \(parameters["q"]!)")
        
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
            
            let jsonParser = CityWeatherForecastJSONParser()
            
            return jsonParser.parse(json: json)
        } catch {
            os_log("Error on response parsing: %@", type: .error, error.localizedDescription)
            return nil
        }
    }
}
