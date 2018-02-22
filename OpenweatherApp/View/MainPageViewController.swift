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
    
    var forecastViewControllers = [NewCityWeatherForecastViewController]()
    
    
    var addCityDialog: AddCityAlertViewController?
    
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
    
    func setCities(cities: [City]) {
        cleanForecastViewControllers()
        
        for city in cities {
            addForecastViewController(city)
        }
        
        reloadPageDatasource()
    }
    
    func addCity(_ city: City) {
        addForecastViewController(city)
        
        reloadPageDatasource()
    }
    
    func getCurrentCityIndex() -> Int {
        return currentIndex
    }
    
    func showAddCityDialog() {
        self.addCityDialog = AddCityAlertViewController.create(with: presenter)
        self.present(self.addCityDialog!, animated: true, completion: nil)
    }
    
    func getCityToAdd() -> City? {
        return addCityDialog?.enteredCity()
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return forecastViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = findIndex(for: viewController)
        
        if let unwrappedIndex = index {
            return unwrappedIndex <= 0 ? nil : forecastViewControllers[unwrappedIndex - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = findIndex(for: viewController)
        
        if let unwrappedIndex = index {
            return unwrappedIndex >= forecastViewControllers.count - 1 ? nil : forecastViewControllers[unwrappedIndex + 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.currentIndex = findIndex(for: pendingViewControllers[0]) ?? 0
    }
    
    // MARK: private methods
    
    private func cleanForecastViewControllers() {
        forecastViewControllers.removeAll()
    }
    
    private func addForecastViewController(_ city: City) {
        let forecastView = NewCityWeatherForecastViewController.create(for: city, mainPresenter: presenter)
        
        forecastViewControllers.append(forecastView)
    }
    
    private func findIndex(for viewController: UIViewController?) -> Int? {
        guard viewController != nil else {
            return nil
        }
        
        if let vc = viewController as? NewCityWeatherForecastViewController {
            return forecastViewControllers.index(of: vc)
        } else {
            return nil
        }
    }
    
    private func reloadPageDatasource() {
        // такой комбинацией вызово удается добиться вызова методов
        // presentationCount for pageViewController и
        // pageViewController _ , viewControllerAfter
        // для корреткного показа числа страниц и возможности перехода на добаленную страницу
        
        // todo: найти более корректный вариант
        if forecastViewControllers.count > currentIndex {
            setViewControllers([forecastViewControllers[currentIndex]], direction: .forward, animated: true, completion: nil)
        }
        
        self.dataSource = nil
        self.dataSource = self
    }
}
