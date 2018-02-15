//
//  YWForecastResponseQueryResultsForecast.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 15.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import ObjectMapper

struct YWForecastResponseQueryResultsForecast: Mappable {
    
    var minTempStr: String!
    var maxTempStr: String!
    var date: Date!
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        minTempStr <- map["item.forecast.low"]
        maxTempStr <- map["item.forecast.high"]
        date <- (map["item.forecast.date"], YWDateTransform())
    }
}
