//
//  YWForecastResponseQueryResults.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 15.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import ObjectMapper

struct YWForecastResponseQueryResults: Mappable {
    
    var forecasts: [YWForecastResponseQueryResultsForecast]?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        forecasts <- map["channel"]
    }
}
