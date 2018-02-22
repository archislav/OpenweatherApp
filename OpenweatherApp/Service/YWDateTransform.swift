//
//  YWDateTransform.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 15.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation
import ObjectMapper

// вид даты 09 Feb 2018
class YWDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let dateStr = value as? String {
            let dateFormatter = DateUtils.createDayMonthNameYearDateFormatter()
            return dateFormatter.date(from: dateStr)
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let dateFormatter = DateUtils.createDayMonthNameYearDateFormatter()
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
