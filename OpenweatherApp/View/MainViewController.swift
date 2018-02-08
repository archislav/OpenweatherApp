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
    
    var presenter: MainPresenterProtocol!
    
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
        
        // setup presenter
        self.presenter = MainPresenter(mainView: self)
        self.presenter.initialize()
        //        let slides = createSlides()
        //        setupSlideScrollView(slides: slides)
    }
    
    func setCityWeatherForecasts(forecasts: [CityWeatherForecast]) {
        // todo: check if zero length
        
        let vFWidth: CGFloat = view.frame.width
        let vFHeight: CGFloat = view.frame.height
        
        // setup page scroll
        pagesScrollView.frame = CGRect(x: 0, y: 0, width: vFWidth, height: vFHeight)
        pagesScrollView.contentSize = CGSize(width: CGFloat(forecasts.count) * vFWidth, height: vFHeight)
        
        for i in 0..<forecasts.count {
            let forecast = forecasts[i]
            
            let forecastView = CityWeatherForecastView.create()
            forecastView.set(forecast: forecast)
            
            forecastView.frame = CGRect(x: vFWidth * CGFloat(i), y: 0, width: vFWidth, height: vFHeight)
            pagesScrollView.addSubview(forecastView)
        }
        
        // setup page control
        pageControl.numberOfPages = forecasts.count
        pageControl.currentPage = 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(pageIndex)
    }
    
    
//    ------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

