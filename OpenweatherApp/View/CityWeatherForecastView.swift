//
//  CityWeatherForecastView.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import UIKit

class CityWeatherForecastView: UIView {

    @IBOutlet weak var cityLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static func create() -> CityWeatherForecastView {
        let view: CityWeatherForecastView = Bundle.main.loadNibNamed("CityWeatherForecastView", owner: self, options: nil)?.first as! CityWeatherForecastView
        
        return view
    }
    
    func set(forecast: CityWeatherForecast) {
        // todo:
        cityLabel.text = forecast.city
    }

}
