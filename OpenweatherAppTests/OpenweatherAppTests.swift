//
//  OpenweatherAppTests.swift
//  OpenweatherAppTests
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import XCTest
@testable import OpenweatherApp

class OpenweatherAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // вид даты 09 Feb 2018
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        
        var date = dateFormatter.date(from: "09 Feb 2018")
        print(">>> \(date)")
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EEEE"
        dateFormatter2.locale = Locale.current
        dateFormatter2.timeZone = TimeZone.current
        
        var str = dateFormatter2.string(from: date!)
        print(">>> \(str)")
    }
    
}
