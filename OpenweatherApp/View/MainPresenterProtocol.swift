//
//  MainPresenterProtocol.swift
//  OpenweatherApp
//
//  Created by Сергей Морозов on 08.02.18.
//  Copyright © 2018 Сергей Морозов. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    
    init(mainView: MainViewProtocol)
    
    func initialize()
}
