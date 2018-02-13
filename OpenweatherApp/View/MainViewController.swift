//
//  ViewController.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate, MainViewProtocol {

    @IBOutlet weak var pagesScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var addCityButton: UIButton!
    
    var addCityAlert: AddCityAlertViewController?
    
    var presenter: MainPresenterProtocol!
    var forecastViews = [CityWeatherForecastView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        // setup pagesScrollView
        pagesScrollView.delegate = self
        pagesScrollView.isPagingEnabled = true
        
        // setup pageControl
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
        
        // setup addCityButton
        view.bringSubview(toFront: addCityButton)
        
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
        return isEmptyCities() ? -1 : pageControl.currentPage
    }
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast, for cityIndex: Int) {
        forecastViews[cityIndex].setWeatherForecast(weatherForecast)
    }
    
    func getEnteredCityToAdd() -> String? {
        return addCityAlert?.enteredCity()
    }
    
    // MARK: UIScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPageOld = pageControl.currentPage
        
        let pageIndex = scrollView.contentOffset.x / view.frame.width
        
        guard pageIndex >= 0 && Int(pageIndex) < pageControl.numberOfPages else {
            return
        }
        
        pageControl.currentPage = Int(pageIndex)
        
        if currentPageOld != pageControl.currentPage {
            presenter.currentCityChanged()
        }
    }
    
    // MARK: Actions
    @IBAction func addCityButtonTapped(_ sender: Any) {
        self.addCityAlert = AddCityAlertViewController.create(with: presenter)
        
        present(self.addCityAlert!, animated: false, completion: nil)
    }
    
    // MARK: private methods
    
    private func cleanCities() {
        let vFWidth: CGFloat = view.frame.width
        let vFHeight: CGFloat = view.frame.height
        
        // setup page scroll
        pagesScrollView.frame = CGRect(x: 0, y: 0, width: vFWidth, height: vFHeight)
        pagesScrollView.contentSize = CGSize(width: 0, height: vFHeight)
        
        // setup page control
        pageControl.numberOfPages = 1
        pageControl.currentPage = 0
        
        // clean views
        forecastViews.removeAll()
    }
    
    private func doAddCity(_ city: String) {
        let wasEmptyCities = isEmptyCities()
        
        let vFWidth: CGFloat = view.frame.width
        let vFHeight: CGFloat = view.frame.height
        
        // setup page scroll
        let oldPagedScrollViewContentWidth = pagesScrollView.contentSize.width
        
        pagesScrollView.contentSize = CGSize(width: oldPagedScrollViewContentWidth + vFWidth, height: vFHeight)
        
        let forecastView = CityWeatherForecastView.create()
        forecastView.setCity(city)
        
        forecastView.frame = CGRect(x: oldPagedScrollViewContentWidth, y: 0, width: vFWidth, height: vFHeight)
        pagesScrollView.addSubview(forecastView)
        
        forecastViews.append(forecastView)
        
        // setup page control
        if wasEmptyCities {
            pageControl.numberOfPages = 1
        } else {
            pageControl.numberOfPages += 1
        }
    }
    
    private func isEmptyCities() -> Bool {
        return forecastViews.isEmpty
    }
}

