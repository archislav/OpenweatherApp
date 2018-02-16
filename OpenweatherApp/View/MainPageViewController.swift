//
//  MainPageViewController.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 16.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, MainViewProtocol {
    
    var presenter: MainPresenterProtocol!
    var forecastViews = [NewCityWeatherForecastViewController]()
    var currentIndex = 0
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        self.delegate = self
        self.dataSource = self
        
        // setup presenter
        self.presenter = MainPresenter(mainView: self)
        self.presenter.initialize()
    }
    
    // MARK: MainViewProtocol methods
    
    func setCities(cities: [String]) {
        cleanCities()
        
        if cities.isEmpty {
            return
        }
        
        for city in cities {
            doAddCity(city)
        }
        
        setViewControllers([forecastViews[0]], direction: .forward, animated: true, completion: nil)
        
        // request weather for current city
        presenter.currentCityChanged()
    }
    
    func addCity(_ city: String) {
        let wasEmptyCities = isEmptyCities()
        
        doAddCity(city)
        
        if wasEmptyCities {
            presenter.currentCityChanged()
        }
    }
    
    func getCurrentCityIndex() -> Int {
        return currentIndex
    }
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast, for cityIndex: Int) {
        forecastViews[cityIndex].setWeatherForecast(weatherForecast)
    }
    
    func getEnteredCityToAdd() -> String? {
//        return addCityAlert?.enteredCity()
        return nil // todo:
    }

    
    // MARK: UIPageViewControllerDataSource
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return forecastViews.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = forecastViews.index(of: viewController as! NewCityWeatherForecastViewController) ?? 0
        
        return index <= 0 ? nil : forecastViews[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = forecastViews.index(of: viewController as! NewCityWeatherForecastViewController) ?? 0
        
        return index >= forecastViews.count - 1 ? nil : forecastViews[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
      
        presenter.currentCityChanged()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.currentIndex = forecastViews.index(of: pendingViewControllers[0] as! NewCityWeatherForecastViewController) ?? 0
    }
    
    // MARK: private methods
    
    private func cleanCities() {
        // clean views
        forecastViews.removeAll()
    }
    
    private func doAddCity(_ city: String) {
        let forecastView = NewCityWeatherForecastViewController.create()
        
        forecastViews.append(forecastView)
    }
    
    private func isEmptyCities() -> Bool {
        return forecastViews.isEmpty
    }
}
