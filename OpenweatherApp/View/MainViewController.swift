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
        // todo: check if zero length
        
        let vFWidth: CGFloat = view.frame.width
        let vFHeight: CGFloat = view.frame.height
        
        // setup page scroll
        pagesScrollView.frame = CGRect(x: 0, y: 0, width: vFWidth, height: vFHeight)
        pagesScrollView.contentSize = CGSize(width: CGFloat(cities.count) * vFWidth, height: vFHeight)
        
        for i in 0..<cities.count {
            let city = cities[i]
            
            let forecastView = CityWeatherForecastView.create()
            forecastView.setCity(city)
            
            forecastView.frame = CGRect(x: vFWidth * CGFloat(i), y: 0, width: vFWidth, height: vFHeight)
            pagesScrollView.addSubview(forecastView)
            
            forecastViews.append(forecastView)
        }
        
        // setup page control
        pageControl.numberOfPages = cities.count
        pageControl.currentPage = 0
        
        // request weather for current city
        presenter.currentCityChanged()
    }
    
    func getCurrentCityIndex() -> Int {
        return pageControl.currentPage
    }
    
    func setWeatherForecast(_ weatherForecast: CityWeatherForecast, for cityIndex: Int) {
        forecastViews[cityIndex].setWeatherForecast(weatherForecast)
    }
    
    // MARK: UIScrollViewDelegate methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPageOld = pageControl.currentPage
        
        let pageIndex = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(pageIndex)
        
        if currentPageOld != pageControl.currentPage {
            presenter.currentCityChanged()
        }
    }
    
    // MARK: Actions
    @IBAction func addCityButtonTapped(_ sender: Any) {
    }
    
//    ------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

