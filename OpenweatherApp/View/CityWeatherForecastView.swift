//
//  CityWeatherForecastView.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import UIKit

class CityWeatherForecastView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    static let CELL_ID = "CONDITIONS_CELL_ID"
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    
    var forecast : CityWeatherForecast?
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    static func create() -> CityWeatherForecastView {
        let view: CityWeatherForecastView = Bundle.main.loadNibNamed("CityWeatherForecastView", owner: self, options: nil)?.first as! CityWeatherForecastView
        
        view.forecastTableView.delegate = view
        view.forecastTableView.dataSource = view
        view.forecastTableView.reloadData()
        
        return view
    }
    
    func setCity(_ city: String) {
        cityLabel.text = city
    }
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast) {
        DispatchQueue.main.async {
            self.forecast = weatherForecast
            
            self.forecastTableView.reloadData()
        }
        
    }
    
    // MARK: TableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.dateWeatherConditions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: CityWeatherForecastView.CELL_ID) ?? UITableViewCell(style: .default, reuseIdentifier: CityWeatherForecastView.CELL_ID)
        
        let conditions = forecast!.dateWeatherConditions[indexPath.row]
        
        let formatter = createDayOfWeekNameFormatter()
        let dayOfWeek = formatter.string(from: conditions.date)
        
        cell.textLabel?.text = "\(dayOfWeek): \(conditions.minTemp)...\(conditions.maxTemp)"
        
        return cell
    }
    
    private func createDayOfWeekNameFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        
        return formatter
    }
    
}
