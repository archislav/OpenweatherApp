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
    
    func requestWeatherForecast(for city: City, successCallback: @escaping ([DateWeatherCondition]) -> ())   {
        let parameters = createWeatherForecastParameters(for: city)
        
        doRequestWeatherForecast(parameters, successCallback)
    }
    
    private func doRequestWeatherForecast(_ parameters: [String: String], _ completionHandler: @escaping ([DateWeatherCondition]) -> ()) {
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
                
                let jsonParser = YWForecastResponseParser()
                
                if var conditionsList = jsonParser.parse(json: json) {
                    completionHandler(conditionsList)
                }
        }
    }
    
    private func createWeatherForecastParameters(for city: City) -> [String: String] {
        let parameters: [String: String] = [
            "q": "select item.forecast from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text=\"\(city.name), ru\" limit 1) and u='c'",
            "format": "json"
        ]
        
        print(">>> q: \(parameters["q"]!)")
        
        return parameters
    }
}
