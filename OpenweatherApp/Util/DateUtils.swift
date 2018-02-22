//
//  DateUtils.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 22.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

class DateUtils {
    
    private init () {}
    
    static func createDayMonthNameYearDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" // например: 09 Feb 2018
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        return dateFormatter
    }
    
    static func createDayOfWeekNameFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter
    }
}
