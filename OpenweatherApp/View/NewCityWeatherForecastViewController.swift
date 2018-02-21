//
//  NewCityWeatherForecastViewController.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 16.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import UIKit

class NewCityWeatherForecastViewController: UIViewController, CityWeatherViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: contants
    static let CELL_ID = "CONDITIONS_CELL_ID"
    
    // MARK: UI elements
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var addCityButton: UIButton!
    
    // MARK: presenter
    var presenter: CityWeatherPresenterProtocol!
    
    // MARK: data
    var forecast : CityWeatherForecast?
    
    static func create(for city: String, mainPresenter: MainPresenterProtocol) -> NewCityWeatherForecastViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewCityWeatherForecastViewController") as! NewCityWeatherForecastViewController
        
        viewController.presenter = CityWeatherPresenter(view: viewController, mainPresenter: mainPresenter)
        viewController.presenter.setCity(city)
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self

        self.presenter.initialize()
    }
    
    // MARK:CityWeatherViewProtocol methods
    func setCity(_ city: String) {
        cityLabel.text = city
    }
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast) {
        DispatchQueue.main.async {
            self.forecast = weatherForecast
            self.forecastTableView.reloadData()
        }
    }
    
    // MARK: actions
    @IBAction func addCityButtonTapped(_ sender: Any) {
        self.presenter.askUserToAddCity()
    }
    
    // MARK: TableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast?.dateWeatherConditions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = forecastTableView.dequeueReusableCell(withIdentifier: NewCityWeatherForecastViewController.CELL_ID) ?? UITableViewCell(style: .default, reuseIdentifier: NewCityWeatherForecastViewController.CELL_ID)
        
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
