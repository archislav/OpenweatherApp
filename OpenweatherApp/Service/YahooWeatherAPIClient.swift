//
//  YahooWeatherAPIClient.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 09.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import os.log
import Alamofire

class YahooWeatherAPIClient {
    
    static let YAHOO_WEATHER_API_URL = "https://query.yahooapis.com/v1/public/yql"
    
    static let shared = YahooWeatherAPIClient()
    
    private init() {}
    
    func requestWeatherForecast(for city: String, successCallback: @escaping (CityWeatherForecast) -> ())   {
        let parameters = createWeatherForecastParameters(for: city)
        
        doRequestWeatherForecast(city, parameters, successCallback)
    }
    
    private func doRequestWeatherForecast(_ city: String, _ parameters: [String: String], _ completionHandler: @escaping (CityWeatherForecast) -> ()) {
        Alamofire.request(YahooWeatherAPIClient.YAHOO_WEATHER_API_URL,
                          method: .post,
                          parameters: parameters)
            .validate()
            .responseString() { response in
                switch response.result {
                case .failure(let error):
                    os_log("Got error on request: %@", type: .error, error.localizedDescription)
                    return
                case .success:
                    break
                }
                
                guard let json = response.result.value else {
                    os_log("Got empty response data", type: .error)
                    return
                }
                
                os_log("Response body: %@", json)
                
                let jsonParser = CityWeatherForecastJSONParser()
                
                if var forecast = jsonParser.parse(json: json) {
                    forecast.city = city
                    completionHandler(forecast)
                }
        }
    }
    
    private func createWeatherForecastParameters(for city: String) -> [String: String] {
        let parameters: [String: String] = [
            "q": "select item.forecast from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"\(city), ru\" limit 1) and u='c'",
            "format": "json"
        ]
        
        print(">>> q: \(parameters["q"]!)")
        
        return parameters
    }
}
