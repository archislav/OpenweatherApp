//
//  City.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 21.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

struct City: Equatable {

    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}


