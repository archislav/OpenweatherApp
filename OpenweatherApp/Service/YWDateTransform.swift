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
            let dateFormatter = createDateFormatter()
            return dateFormatter.date(from: dateStr)
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let dateFormatter = createDateFormatter()
            return dateFormatter.string(from: date)
        }
        return nil
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
